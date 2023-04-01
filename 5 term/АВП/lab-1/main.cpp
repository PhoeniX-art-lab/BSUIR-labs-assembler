#include <iostream>
#include <chrono>
#include <immintrin.h>
#include <cmath>

const int INNER_SIZE = 16;
const int ROWS_1 = 150;
const int COLS_1 = 200;
const int ROWS_2 = 200;
const int COLS_2 = 150;
const int accuracy = 10;

double** CreateMatrix(double** matrix, int rows, int cols, int inner_size, int value);
void DeleteMatrix(double** matrix, int rows, int cols);

void AutoVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I);
void AutoVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N);
void NotVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I);
void NotVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N);
void AVXVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I);
void AVXVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N);

bool Compare(double** matrix_1, double** matrix_2, int rows, int cols, int inner_size);

void Display(double* matr, int N, int M) {
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            std::cout << matr[i * N + j] << " ";
        }
        std::cout << std::endl;
    }
}

int main(int argc, char* argv[]) {
    double** matrix_1, ** matrix_2, ** res_matrix_1, ** res_matrix_2, ** res_matrix_3;

    matrix_1 = matrix_2 = res_matrix_1 = res_matrix_2 = res_matrix_3 = { 0 };

    matrix_1 = CreateMatrix(matrix_1, ROWS_1, COLS_1, INNER_SIZE, 15);
    matrix_2 = CreateMatrix(matrix_2, ROWS_2, COLS_2, INNER_SIZE, 15);
    res_matrix_1 = CreateMatrix(res_matrix_1, ROWS_1, COLS_2, INNER_SIZE, 0);
    res_matrix_2 = CreateMatrix(res_matrix_2, ROWS_1, COLS_2, INNER_SIZE, 0);
    res_matrix_3 = CreateMatrix(res_matrix_3, ROWS_1, COLS_2, INNER_SIZE, 0);

    using namespace std::chrono;

    high_resolution_clock::time_point t1 = high_resolution_clock::now();
    AutoVectorizedMultiplyMatrices(res_matrix_1, matrix_1, matrix_2, ROWS_1, COLS_2, ROWS_2, INNER_SIZE);
    high_resolution_clock::time_point t2 = high_resolution_clock::now();
    duration<double> auto_v_time = duration_cast<duration<double>>(t2 - t1);
    std::cout << "Auto vectorization time: " << auto_v_time.count() << std::endl;


    t1 = high_resolution_clock::now();
    NotVectorizedMultiplyMatrices(res_matrix_2, matrix_1, matrix_2, ROWS_1, COLS_2, ROWS_2, INNER_SIZE);
    t2 = high_resolution_clock::now();
    duration<double> not_v_time = duration_cast<duration<double>>(t2 - t1);
    std::cout << "Without vectorization time: " << not_v_time.count() << std::endl;

    //Display(res_matrix_2[0], INNER_SIZE, INNER_SIZE);

    t1 = high_resolution_clock::now();
    AVXVectorizedMultiplyMatrices(res_matrix_3, matrix_1, matrix_2, ROWS_1, COLS_2, ROWS_2, INNER_SIZE);
    t2 = high_resolution_clock::now();
    duration<double> avx_v_time = duration_cast<duration<double>>(t2 - t1);
    std::cout << "AVX vectorization time: " << avx_v_time.count() << std::endl;

    //Display(res_matrix_3[0], INNER_SIZE, INNER_SIZE);

    if (Compare(res_matrix_1, res_matrix_2, ROWS_1, COLS_2, INNER_SIZE))
        std::cout << "Auto vectorization matrix and without vectorization matrix are the same." << std::endl;

    if (Compare(res_matrix_3, res_matrix_2, ROWS_1, COLS_2, INNER_SIZE))
        std::cout << "AVX vectorization matrix and without vectorization matrix are the same." << std::endl;

    DeleteMatrix(matrix_1, ROWS_1, COLS_1);
    DeleteMatrix(matrix_2, ROWS_2, COLS_2);
    DeleteMatrix(res_matrix_1, ROWS_1, COLS_2);
    DeleteMatrix(res_matrix_2, ROWS_1, COLS_2);
    DeleteMatrix(res_matrix_3, ROWS_1, COLS_2);
}

void AutoVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I) {
    double* temp_matrix = new double[INNER_SIZE * INNER_SIZE];

    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            for (int k = 0; k < K; ++k) {
                AutoVectorizedMultiplySubmatrices(temp_matrix, matrix_1[i * K + k], matrix_2[k * N + j], INNER_SIZE);

                for (int x = 0; x < I; ++x)
                    for (int y = 0; y < I; ++y)
                        result_matrix[i * N + j][x * I + y] += temp_matrix[x * I + y];
            }
        }
    }

    delete[] temp_matrix;
}

void AutoVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N) {
    for (int i = 0; i < N; ++i) {
        double* res = result_matrix + i * N;

        for (int j = 0; j < N; ++j)
            res[j] = 0;

        for (int k = 0; k < N; ++k) {
            double m_1 = matrix_1[i * N + k];
            const double* m_2 = matrix_2 + k * N;
            for (int j = 0; j < N; ++j)
                res[j] += m_1 * m_2[j];
        }
    }
}

void NotVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I) {
    double* temp_matrix = new double[INNER_SIZE * INNER_SIZE];
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            for (int k = 0; k < K; ++k) {
                NotVectorizedMultiplySubmatrices(temp_matrix, matrix_1[i * K + k], matrix_2[k * N + j], INNER_SIZE);

                for (int x = 0; x < I; ++x)
                    for (int y = 0; y < I; ++y)
                        result_matrix[i * N + j][x * I + y] += temp_matrix[x * I + y];
            }
        }
    }
    delete[] temp_matrix;
}

__attribute__((target("no-sse,no-avx")))
void NotVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N) {
    for (int i = 0; i < N; ++i) {
        double* res = result_matrix + i * N;

        for (int j = 0; j < N; ++j)
            res[j] = 0;

        for (int k = 0; k < N; ++k) {
            double m_1 = matrix_1[i * N + k];
            const double* m_2 = matrix_2 + k * N;

            for (int j = 0; j < N; ++j)
                res[j] += m_1 * m_2[j];
        }
    }
}

void AVXVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I) {
    double* temp_matrix = new double[INNER_SIZE * INNER_SIZE];

    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            for (int k = 0; k < K; ++k) {
                AVXVectorizedMultiplySubmatrices(temp_matrix, matrix_1[i * K + k], matrix_2[k * N + j], INNER_SIZE);

                for (int x = 0; x < I; ++x)
                    for (int y = 0; y < I; ++y)
                        result_matrix[i * N + j][x * I + y] += temp_matrix[x * I + y];
            }
        }
    }

    delete[] temp_matrix;
}

void AVXVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N) {
    for (int i = 0; i < N; ++i) {
        double* res = result_matrix + i * N;

        for (int j = 0; j < N; j += 4)
            _mm256_storeu_pd(res + j , _mm256_setzero_pd());

        for (int k = 0; k < N; ++k) {
            __m256d m_1 = _mm256_set1_pd(matrix_1[i * N + k]);
            const double* m_2 = matrix_2 + k * N;
            for (int j = 0; j < N; j += 4)
                _mm256_storeu_pd(res + j, _mm256_add_pd(_mm256_loadu_pd(res + j),
                                                        _mm256_mul_pd(_mm256_loadu_pd(m_2 + j), m_1)));
        }
    }
}

bool Compare(double** matrix_1, double** matrix_2, int rows, int cols, int inner_size) {
    for (int i = 0; i < rows * cols; i++)
        for (int j = 0; j < inner_size * inner_size; j++)
            if ((int) pow(matrix_1[i][j], accuracy) != (int) pow(matrix_2[i][j], accuracy))
                return false;
    return true;
}

double** CreateMatrix(double** matrix, int rows, int cols, int inner_size, int value) {
    matrix = new double* [rows * cols];
    for (int i = 0; i < rows * cols; i++) {
        matrix[i] = new double [inner_size * inner_size];
        for (int j = 0; j < inner_size * inner_size; j++)
            matrix[i][j] = value ? (double)(rand() % value) + ((double)rand() / RAND_MAX) : 0;
    }
    return matrix;
}

void DeleteMatrix(double** matrix, int rows, int cols) {
    for (auto i = 0; i < rows * cols; i++)
        delete[] matrix[i];
    delete[] matrix;
}
