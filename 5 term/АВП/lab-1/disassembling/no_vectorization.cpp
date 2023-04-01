#include <iostream>
#include <immintrin.h>

const int INNER_SIZE = 16;
const int ROWS_1 = 150;
const int COLS_1 = 200;
const int ROWS_2 = 200;
const int COLS_2 = 150;

double** CreateMatrix(double** matrix, int rows, int cols, int inner_size, int value);

void NotVectorizedMultiplyMatrices(double** result_matrix, double** matrix_1, double** matrix_2, int M, int N, int K, int I);
void NotVectorizedMultiplySubmatrices(double* result_matrix, double* matrix_1, double* matrix_2, int N);

int main() {
    double** matrix_1, ** matrix_2, ** res_matrix_1, ** res_matrix_2, ** res_matrix_3;

    matrix_1 = matrix_2 = res_matrix_1 = res_matrix_2 = res_matrix_3 = { 0 };

    matrix_1 = CreateMatrix(matrix_1, ROWS_1, COLS_1, INNER_SIZE, 15);
    matrix_2 = CreateMatrix(matrix_2, ROWS_2, COLS_2, INNER_SIZE, 15);
    res_matrix_2 = CreateMatrix(res_matrix_2, ROWS_1, COLS_2, INNER_SIZE, 0);

    NotVectorizedMultiplyMatrices(res_matrix_2, matrix_1, matrix_2, ROWS_1, COLS_2, ROWS_2, INNER_SIZE);

    return 0;
}


__attribute__((target("no-sse,no-avx")))
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


double** CreateMatrix(double** matrix, int rows, int cols, int inner_size, int value) {
    matrix = new double* [rows * cols];
    for (int i = 0; i < rows * cols; i++) {
        matrix[i] = new double [inner_size * inner_size];
        for (int j = 0; j < inner_size * inner_size; j++)
            matrix[i][j] = value ? (double)(rand() % value) + ((double)rand() / RAND_MAX) : 0;
    }
    return matrix;
}
