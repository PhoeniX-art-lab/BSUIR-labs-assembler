#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <time.h>
#include <pthread.h>

typedef uint16_t WORD;
typedef uint32_t DWORD;
typedef int32_t LONG;
#define ERROR_CREATE_THREAD -11
#define ERROR_JOIN_THREAD   -12
#define SUCCESS               0

typedef struct tagBITMAPFILEHEADER {
    uint16_t file_type;               // File type always BM which is 0x4D42
    uint32_t file_size;               // Size of the file (in bytes)
    uint16_t reserved1;               // Reserved, always 0
    uint16_t reserved2;               // Reserved, always 0
    uint32_t offset_data;
} BITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER{
    uint32_t size;
    int32_t width;
    int32_t height;

    uint16_t planes;
    uint16_t bit_count;
    uint32_t compression;
    uint32_t size_image;
    int32_t x_pixels_per_meter;
    int32_t y_pixels_per_meter;
    uint32_t colors_used;
    uint32_t colors_important;
} BITMAPINFOHEADER;

FILE *sourceFile, *destFile;
int threads_num = 2;
long source_file_pointer, dest_file_pointer;

void* ConvertToGrayscale(void *arg) {
    int index = *(int*)arg;
    unsigned char gray, r, g, b;
    for (int i = index * 3;!feof(sourceFile); i += 3 * threads_num) {
        fseek(sourceFile, source_file_pointer + i, SEEK_SET);
        fread(&r, sizeof(char), 1, sourceFile);
        fread(&g, sizeof(char), 1, sourceFile);
        fread(&b, sizeof(char), 1, sourceFile);

        gray = ((0.30 * r) + (0.59 * g) + (0.11 * b));
        r = gray;
        g = gray;
        b = gray;

        fseek(destFile, dest_file_pointer + i, SEEK_SET);
        fwrite(&r, sizeof(char), 1, destFile);
        fwrite(&g, sizeof(char), 1, destFile);
        fwrite(&b, sizeof(char), 1, destFile);
    }
    return NULL;
}

void WriteStandardBMPInfo(const char* name) {
    BITMAPFILEHEADER file_header;
    BITMAPINFOHEADER info_header;

    sourceFile = fopen("1.bmp", "rb");
    destFile = fopen(name, "wb");

    fread(&file_header, sizeof(file_header), 1, sourceFile);
    fread(&info_header, sizeof(info_header), 1, sourceFile);

    fwrite(&file_header, sizeof(file_header), 1, destFile);
    fwrite(&info_header, sizeof(info_header), 1, destFile);

    fseek(sourceFile, 56, SEEK_SET);
    fseek(destFile, 56, SEEK_SET);
    source_file_pointer = ftell(sourceFile);
    dest_file_pointer = ftell(destFile);
}

int main() {
    WriteStandardBMPInfo("result.bmp");
    struct timeval Start;
    struct timeval End;
    clock_t start, end;
    start = clock();
    pthread_t th[threads_num];
    gettimeofday(&Start, NULL);
    for (int i = 0; i < threads_num; i++) {
        if (pthread_create(&th[i], NULL, &ConvertToGrayscale, (th + i)) != 0)
            perror("Failed to create thread");
    }
    for (int i = 0; i < threads_num; i++)
        if (pthread_join(th[i], NULL) != 0)
            perror("Failed to join thread");
    gettimeofday(&End, NULL);
    struct timeval exectime;
    timersub(&End, &Start, &exectime);
    // end = clock();
    // printf("Thread time: %lf sec\n", (double)(end - start) / CLOCKS_PER_SEC);
    printf("Thread time: %ld.%06ld sec\n", (long int)exectime.tv_sec, (long int)exectime.tv_usec);
    fclose(sourceFile);
    fclose(destFile);

    WriteStandardBMPInfo("result1.bmp");
    start = clock();
    unsigned char gray, r, g, b;
    for (;!feof(sourceFile);) {
        fread(&r, sizeof(char), 1, sourceFile);
        fread(&g, sizeof(char), 1, sourceFile);
        fread(&b, sizeof(char), 1, sourceFile);

        gray = ((0.30 * r) + (0.59 * g) + (0.11 * b));
        r = gray;
        g = gray;
        b = gray;

        fwrite(&r, sizeof(char), 1, destFile);
        fwrite(&g, sizeof(char), 1, destFile);
        fwrite(&b, sizeof(char), 1, destFile);
    }
    end = clock();
    printf("Single time: %lf sec\n", (double)(end - start) / CLOCKS_PER_SEC);
    fclose(sourceFile);
    fclose(destFile);

    return 0;
}