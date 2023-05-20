#ifndef CUDACC_RTC
#define CUDACC_RTC
#endif
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include "device_functions.h"
#include <opencv2/opencv.hpp>
#include <opencv2/photo/cuda.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/core/cuda.hpp>
#include<assert.h>
#include <stdio.h>
#include <cmath>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <curand.h>
#include<curand_kernel.h>
#include<vector>
#include<numeric>

using namespace std;
using namespace std::chrono;
#define AMOUNT 100000000
#define GRID_SIZE 128

using namespace cv;
using namespace std;

__global__ void thresholdImageKernel(unsigned char* colorData, unsigned char* thresholdData,
	int colorPitch, int thresholdPitch, int rows, int cols) {
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	if (row < rows && col < cols) {
		// Вычисление указателя на текущий пиксель в буфере цветовых данных
		unsigned char* rowPtr = colorData + row * colorPitch;
		unsigned char color = rowPtr[col * 3];	// Получение значения цвета для текущего пикселя

		// Приведение значения цвета к 0 или 255 и запись результата в выходной буфер
		thresholdData[row * thresholdPitch + col] = (color == 255) ? 255 : 0;
	}
}

__global__ void HoughTransformKernel(unsigned char* src, size_t rows, size_t cols, size_t pitch, int* accumulator,
	float diagonal)
{
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	if (row < rows && col < cols) {
		if (*(src + pitch * row + col) > 0)	// Проверка, является ли пиксель белым
		{
			// Перебор всех возможных углов для поиска линии на входном изображении
			for (int t = 0; t < 180; t++)
			{
				// Вычисление расстояния между текущим пикселем и линией под текущим углом
				float r = (float)(col * cosf(t * CV_PI / 180) + row * sinf(t * CV_PI / 180));
				// Вычисляем индекс в массиве аккумуляторов для этой строки
				int irho = int(r + diagonal / 2);

				// Добавляем угол для данной строки в массив аккумуляторов
				atomicAdd(accumulator + 180 * irho + t, 1);
			}
		}
	}
}

__global__ void rotateImageKernel(uchar* src, uchar* dst, int srcPitch, int dstPitch, int cols, int rows, double angle, int channels,
	int centerX, int centerY, double sinAngle, double cosAngle)
{
	int x = blockIdx.x * blockDim.x + threadIdx.x;
	int y = blockIdx.y * blockDim.y + threadIdx.y;

	if (y < rows && x < cols)
	{	
		// Вычисляем повернутые координаты xRotated и yRotated для каждого потока, используя центр вращения и угол
		double xRotated = (x - centerX) * cosAngle - (y - centerY) * sinAngle + centerX;
		double yRotated = (x - centerX) * sinAngle + (y - centerY) * cosAngle + centerY;

		// Вычисляем четыре окружающих пикселя x1, x2, y1 и y2 вокруг повернутых координат
		int x1 = floor(xRotated);
		int x2 = ceil(xRotated);
		int y1 = floor(yRotated);
		int y2 = ceil(yRotated);

		// Вычисляем расстояние между повернутыми координатами и окружающими пикселями
		double dx1 = xRotated - x1;
		double dx2 = x2 - xRotated;
		double dy1 = yRotated - y1;
		double dy2 = y2 - yRotated;

		// Прижимаем окружающие пиксели к границе изображения
		x1 = max(0, min(x1, cols - 1));
		x2 = max(0, min(x2, cols - 1));
		y1 = max(0, min(y1, rows - 1));
		y2 = max(0, min(y2, rows - 1));

		for (int c = 0; c < channels; c++)
		{
			// Вычисляем средневзвешенное значение четырех окружающих пикселей по расстояниям dx, dy
			double value = src[y1 * srcPitch + x1 * channels + c] * dx2 * dy2
				+ src[y1 * srcPitch + x2 * channels + c] * dx1 * dy2
				+ src[y2 * srcPitch + x1 * channels + c] * dx2 * dy1
				+ src[y2 * srcPitch + x2 * channels + c] * dx1 * dy1;
			dst[y * dstPitch + x * channels + c] = static_cast<uchar>(value); // Сохраняем результат в изображении
		}
	}
}

int main(int argc, char** argv)
{

	//Mat h_src(500, 500, CV_8UC3, Scalar(255, 255, 255));
	Mat h_src = cv::imread("/YourPath", cv::IMREAD_COLOR);
	float angle = (float)(rand() % 360 - 180) * CV_PI / 180.0;
	float x_start = h_src.cols / 2; // определение точки центра изображения по горизонтали
	float y_start = h_src.rows / 2; // определение точки центра изображения по вертикали
	line(h_src,
		Point(x_start, y_start),
		Point(x_start + 500 * cos(angle), y_start + 500 * sin(angle)),
		Scalar(255, 0, 0),
		6);
	imshow("source", h_src);
	waitKey(0);

	unsigned char* colorData = h_src.ptr<unsigned char>(); // получаем указатель на пиксельное изображение
	size_t rows = h_src.rows; // количество строк в изображении
	size_t cols = h_src.cols; // количество столбцов в изображении

	// Выделяем память на устройстве для указателей на цветное и пороговое изображение
	uchar* d_colorData;
	uchar* d_thresholdData;

	size_t colorPitch;
	cudaMallocPitch((void**)&d_colorData, &colorPitch, cols * 3 * sizeof(unsigned char), rows);

	size_t threshholdPitch;
	cudaMallocPitch((void**)&d_thresholdData, &threshholdPitch, cols * sizeof(unsigned char), rows);

	cudaMemcpy2D(d_colorData, colorPitch, colorData, cols * 3 *
		sizeof(unsigned char),
		cols * 3 * sizeof(unsigned char), rows, cudaMemcpyHostToDevice);
	dim3 block(16, 16);
	dim3 grid((cols + block.x - 1) / block.x, (rows + block.y - 1) / block.y);
	thresholdImageKernel <<<grid, block>>>(d_colorData, d_thresholdData, colorPitch,
		threshholdPitch, rows, cols);
	


	uchar* test = new unsigned char[rows * cols * 3];
	cudaMemcpy2D(test, cols * 3 * sizeof(uchar), d_thresholdData, threshholdPitch,
		cols * sizeof(uchar), rows, cudaMemcpyDeviceToHost);

	Mat cv_test(rows, cols, CV_8UC3, test);
	
	imshow("test", cv_test);
	waitKey(0);
 	

	// Вычисляем длину диагонали изображения
	float diagonal = sqrt((float)cols * cols + (float)rows * rows);

	// Выделяем память на устройстве для указателя на массив аккумулятора
	int* d_accumulator;
	cudaMalloc((void**)&d_accumulator, 180 * (int)diagonal * sizeof(int));

	HoughTransformKernel <<<grid, block >>>(d_thresholdData, rows, cols, threshholdPitch, d_accumulator,
		diagonal);

	// Копируем массив аккумулятора с девайса на хост
	int* accumulator = new int[180 * (int)diagonal];
	cudaMemcpy(accumulator, d_accumulator, 180 * (int)diagonal * sizeof(int), cudaMemcpyDeviceToHost);

	// Создаем вектор линий
	std::vector<cv::Vec2f> lines;
	// Проходимся по каждой строке и столбцу в аккумуляторе, чтобы найти линии
	for (int r = 0; r < (int)diagonal; r++)
	{
		for (int t = 0; t < 180; t++)
		{
			if (accumulator[180 * r + t] >= 500)	// значение в аккумуляторе больше порогового
			{	
				// Сохраняем найденную линию
				cv::Vec2f line(r - (int)diagonal / 2, t);
				lines.push_back(line);

				if (lines.size() >= 20)	// если нашли достаточно линий
				{
					break;
				}
			}
		}
	}

	// Выводим координаты линий
	for (auto item : lines)
	{
		std::cout << item << std::endl;
	}
	cout << endl << endl << lines.size();

	uchar* d_result;
	size_t resultPitch;
	double sinAngle = sin(lines[0][1] * CV_PI / 180);
	double cosAngle = cos(lines[0][1] * CV_PI / 180);

	cudaMallocPitch((void**)&d_result, &resultPitch, cols * 3 * sizeof(unsigned char), rows);

	rotateImageKernel << <grid, block >> >(d_colorData, d_result, colorPitch, resultPitch, cols, rows, lines[0][1] * CV_PI / 180, 3,
		cols / 2, rows / 2, sinAngle, cosAngle);

	uchar* result = new unsigned char[rows * cols * 3];
	cudaMemcpy2D(result, cols * 3 * sizeof(uchar), d_result, resultPitch,
		cols * 3 * sizeof(unsigned char), rows, cudaMemcpyDeviceToHost);

	Mat cv_dst(rows, cols, CV_8UC3, result);

	imshow("result", cv_dst);
	waitKey(0);

	destroyAllWindows();
	return 0;
}
