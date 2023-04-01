#include <iostream>
#include <cstring>
#include <chrono>
#include <cstdlib>

#define L3_CACHE (4 * 1024 * 1024)
#define L3_SZ (L3_CACHE / 8)
#define ASS_MAX 30


uint64_t *createArray() {
    auto *temp = (uint64_t *) aligned_alloc(8 * sizeof(uint64_t), 2 * ASS_MAX * L3_CACHE);
    if (temp != nullptr)
        std::memset(temp, 0, static_cast<size_t>(2 * ASS_MAX * L3_CACHE));
    else
        std::cerr << "ERRRMEM in createArray()" << std::endl;

    return temp;
}


void initArray(auto array, auto associativity) {
    if (array != nullptr) {
        for (int i = 0; i < (associativity - 1); i++)
            array[L3_SZ * i] = L3_SZ * (i + 1);

        array[L3_SZ * (associativity - 1)] = 0;
    } else
        std::cerr << "ERRMEM in InitArray(uint64_t* arr, int associativity)" << std::endl;
}


int main() {
    uint64_t *arr = createArray();
    for (int i = 2; i <= ASS_MAX; i++) {
        initArray(arr, i);
        volatile uint64_t t = 0;

        auto t1 = std::chrono::high_resolution_clock::now();
        for (long long k = 0; k < 100000000; k++)
            t = arr[t];
        auto t2 = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double> time = t2 - t1;

        std::cout << time.count() << std::endl;
    }

    free(arr);

    return 0;
}
