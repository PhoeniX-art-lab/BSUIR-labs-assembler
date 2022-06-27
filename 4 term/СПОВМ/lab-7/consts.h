//
// Created by phoenix on 26.04.2022.
//

#ifndef LAB_7_CONSTS_H
#define LAB_7_CONSTS_H

#endif //LAB_7_CONSTS_H

#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <sys/time.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>

typedef uint16_t WORD;
typedef uint32_t DWORD;
typedef int32_t LONG;
#define ERROR_CREATE_THREAD -11
#define ERROR_JOIN_THREAD   -12
#define SUCCESS               0
#define file_count 3

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

int threads_num = file_count;
FILE* file_array[file_count * 2];    // source1, dest1, source2, dest2