#include <iostream>
#include <chrono>
#include <stdlib.h>
#include <time.h>

#define N 15
#define M 1


void TransformArrayHost(const short *input_array, short **result_array) {
    for (int i = 0; i < N; i++)
        result_array[i][0] = input_array[i];
}


__global__ void TransformArrayDevice(const short *input_array, short **result_array_dev_dev) {
    auto i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N)
        result_array_dev_dev[i][0] = input_array[i];
}


bool Compare(short **gpu_array, short **cpu_array) {
    auto temp = new short[M];
    for (int i = 0; i < N; i++) {
        cudaMemcpy(temp, gpu_array[i], M * sizeof(short), cudaMemcpyDeviceToHost);
        if (temp[0] != cpu_array[i][0])
            return false;
    }
    return true;
}


int main() {
    srand(time(NULL));
    auto *input_array = new short[N];

    auto **result_array = new short *[N];
    for (int i = 0; i < N; i++)
        result_array[i] = new short[M];

    // Allocate memory for 2D array
    short *result_array_dev_flat;
    cudaMalloc((void **) &result_array_dev_flat, N * M * sizeof(short));
    auto **result_array_dev = new short *[N];
    for (int i = 0; i < N; i++)
        result_array_dev[i] = &result_array_dev_flat[i * M];
    short **result_array_dev_dev;
    cudaMalloc((void **) &result_array_dev_dev, N * sizeof(short *));
    cudaMemcpy(result_array_dev_dev, result_array_dev, N * sizeof(short *), cudaMemcpyHostToDevice);

    // Fill input array with values
    for (int i = 0; i < N; i++)
        input_array[i] = rand() % 100;

    // Create input_array for device
    short *input_array_dev;
    cudaMalloc((void **) &input_array_dev, N * sizeof(short));
    cudaMemcpy(input_array_dev, input_array, N * sizeof(short), cudaMemcpyHostToDevice);

    std::cout << "--------------Source Array--------------" << std::endl;
    for (int i = 0; i < N; i++)
        printf("%d ", input_array[i]);
    std::cout << std::endl;

    // CPU processing
    auto t1 = std::chrono::high_resolution_clock::now();
    TransformArrayHost(input_array, result_array);
    auto t2 = std::chrono::high_resolution_clock::now();
    std::cout << "--------------CPU Array--------------" << std::endl;
    std::cout << ((std::chrono::duration<double>) (t2 - t1)).count() << std::endl;
    for (int i = 0; i < N; i++)
        printf("%d\n", result_array[i][0]);

    // GPU processing
    t1 = std::chrono::high_resolution_clock::now();
    dim3 threadsPerBlock(512);
    dim3 numBlocks((N + threadsPerBlock.x - 1) / threadsPerBlock.x);
    TransformArrayDevice<<<numBlocks, threadsPerBlock>>>(input_array_dev, result_array_dev_dev);
    t2 = std::chrono::high_resolution_clock::now();

    cudaMemcpy(result_array_dev, result_array_dev_dev, sizeof(short *) * N, cudaMemcpyDeviceToHost);
    auto temp = new short[M];
    std::cout << "--------------GPU Array--------------" << std::endl;
    std::cout << ((std::chrono::duration<double>) (t2 - t1)).count() << std::endl;
    for (int i = 0; i < N; i++) {
        cudaMemcpy(temp, result_array_dev[i], M * sizeof(short), cudaMemcpyDeviceToHost);
        std::cout << temp[0] << std::endl;
    }
    if (Compare(result_array_dev, result_array))
        std::cout << "CPU and GPU arrays are equal" << std::endl;
    else
        std::cout << "CPU and GPU arrays aren't equal" << std::endl;

    cudaFree(input_array_dev);
    cudaFree(result_array_dev_dev);
    cudaFree(result_array_dev_flat);
    delete[] temp;
    delete[] input_array;
    for (int i = 0; i < N; i++)
        delete[] result_array[i];
    delete[] result_array;

    return 0;
}
