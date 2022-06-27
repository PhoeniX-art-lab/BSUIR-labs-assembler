#define FILENAME "random.bin"

#include <pthread.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <limits.h>

struct thread_info {
    pthread_t id;
    int number;
    char **address;
    long int thread_size;
    int *block_size;
    int *flag;
    pthread_barrier_t *barrier;
};

void* routine(void *);
int sorted(const void*, const void *);

int main() {
    long int pages_number, threads_number;
    printf("Enter count of threads: ");
    scanf("%ld", &threads_number);
    rewind(stdin);
    printf("Enter count of pages: ");
    scanf("%ld", &pages_number);
    rewind(stdin);

    long int page_size = sysconf(_SC_PAGE_SIZE);
    long int thread_size = pages_number * page_size;
    long int block_size = thread_size * threads_number;

    int fd = open(FILENAME, O_RDWR);           // Режим для чтения и записи

    struct stat file_stat;                              // Создаем структуру файла, из которой будем получать его размер
    if (fstat(fd, &file_stat) == -1) {
        perror("fstat error!");
        return 0;
    }

    pthread_barrier_t barrier;
    if (pthread_barrier_init(&barrier, NULL, threads_number + 1) != 0) {
        perror("Initializing barrier error!");
        return 0;
    }

    int blocks_size = 0;
    int flag = 1;
    char *address;
    struct thread_info *info;
    if ((info = calloc(threads_number, sizeof(struct thread_info))) == NULL) {
        perror("calloc error!");
        return 0;
    }

    for (int i = 0; i < threads_number; i++) {
        info[i].number = i + 1;
        info[i].address = &address;
        info[i].thread_size = thread_size;
        info[i].block_size = &blocks_size;
        info[i].flag = &flag;
        info[i].barrier = &barrier;
        if (pthread_create(&info[i].id, NULL, &routine, &info[i]) != 0) {
            perror("Failed to create thread");
            return 0;
        }
    }

    off_t offset = 0;
    off_t remaining_size = file_stat.st_size;
    int count = 0;

    while (remaining_size > 0) {
        if (remaining_size > block_size) {
            blocks_size = block_size;
        } else {
            blocks_size = remaining_size;
        }

        address = mmap(NULL, blocks_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
        if (address == MAP_FAILED) {
            perror("mmap error!");
            return 0;
        }

        offset += block_size;
        remaining_size -= block_size;

        if (remaining_size <= 0)
            flag = 0;

        pthread_barrier_wait(&barrier);

        pthread_barrier_wait(&barrier);

        if (msync(address, blocks_size, MS_SYNC) == -1) {
            perror("msync error!");
            return 0;
        }
        if(munmap(address, blocks_size) == -1) {
            perror("munmap error!");
            return 0;
        }

        if (++count == 100) {
            count = 0;
            float processed_value = (float)(file_stat.st_size - remaining_size) / file_stat.st_size * 100;
            if (processed_value > 100.00f)
                processed_value = 100.00f;
            printf("%.2f%%\n", processed_value);
        }
    }

    printf("%.2f%%\n", 100.00f);


    if (pthread_barrier_destroy(&barrier) != 0)
        perror("Unable to destroy barrier!");

    if (close(fd) == -1) {
        perror("Unable to close the file!");
        return 0;
    }

    return 0;
}


void *routine(void *arg) {
    struct thread_info* info = arg;

    while (*info->flag) {
        pthread_barrier_wait(info->barrier);

        long int start = (info->number - 1) * info->thread_size;
        if (start >= *info->block_size) {                           // Если за раз сортируется объем больше, чем размер блока
            pthread_barrier_wait(info->barrier);
            pthread_exit(0);
        }
        long int size;
        if ((*info->block_size - start) > info->thread_size)        // Если остаток необработанного файла на последнем раунде будет меньше размера блока
            size = info->thread_size;
        else
            size = *info->block_size - start;

        size = size - (size % sizeof(uint32_t));
        qsort(*info->address + start, size / sizeof(uint32_t), sizeof(uint32_t), sorted);
        pthread_barrier_wait(info->barrier);
    }

    pthread_exit(0);
}

int sorted(const void *number1, const void* number2) {
    uint32_t arg1 = *(const uint32_t*)number1;
    uint32_t  arg2 = *(const uint32_t*)number2;

    if (arg1 > arg2) return 1;
    if (arg1 < arg2) return -1;

    return 0;
}
