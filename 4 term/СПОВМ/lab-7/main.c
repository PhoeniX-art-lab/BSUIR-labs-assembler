#include "consts.h"

void* ConvertToGrayscale(void *arg);
void WriteStandardBMPInfo(const char* dest_name, const char* source_name, int sourceFile, int destFile);
int menu();

void handler(){

}

int main() {
    pthread_t th[threads_num];

    WriteStandardBMPInfo("1_res.bmp", "1.bmp", 0, 1);
    WriteStandardBMPInfo("2_res.bmp", "2.bmp", 2, 3);
    WriteStandardBMPInfo("3_res.bmp", "3.bmp", 4, 5);
    for (int i = 0; i < threads_num; i++) {
        int *temp = malloc(sizeof(int));
        *temp = i;
        if (pthread_create(&th[i], NULL, &ConvertToGrayscale,  temp) != 0)
            perror("Failed to create thread");
    }

    printf("Enter:\n1 - to use thread 1\n2 - to use thread 2\n3 - to use thread 3\n4 - to exit\n>");
    while (1) {
        switch (menu()) {
            case 1:
                pthread_kill(th[0], SIGUSR1);
                break;
            case 2:
                pthread_kill(th[1], SIGUSR1);
                break;
            case 3:
                pthread_kill(th[2], SIGUSR1);
                break;
            case 4:
                for (int i = 0; i < threads_num * 2; i++)
                    fclose(file_array[i]);
                return 0;
        }
    }

}

void* ConvertToGrayscale(void *arg) {
    struct sigaction act;
    act.sa_handler = handler;       // SIG_DFL для выполнения стандартных действий, SIG_IGN для игнорирования сигнала
    sigaction(SIGUSR1, &act, 0);

    int index = *(int*)arg;
    int sig;
    index *= 2;
    unsigned char gray, r, g, b;
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SIGUSR1);

    sigwait(&set, &sig);
    pthread_detach(pthread_self());
    for (;!feof(file_array[index]);) {
        fread(&r, sizeof(char), 1, file_array[index]);
        fread(&g, sizeof(char), 1, file_array[index]);
        fread(&b, sizeof(char), 1, file_array[index]);

        gray = ((0.30 * r) + (0.59 * g) + (0.11 * b));
        r = gray;
        g = gray;
        b = gray;

        fwrite(&r, sizeof(char), 1, file_array[index + 1]);
        fwrite(&g, sizeof(char), 1, file_array[index + 1]);
        fwrite(&b, sizeof(char), 1, file_array[index + 1]);
    }
    free(arg);
    return NULL;
}

void WriteStandardBMPInfo(const char* dest_name, const char* source_name, int sourceFile, int destFile) {
    BITMAPFILEHEADER file_header;
    BITMAPINFOHEADER info_header;

    file_array[sourceFile] = fopen(source_name, "rb");
    file_array[destFile] = fopen(dest_name, "wb");

    fread(&file_header, sizeof(file_header), 1, file_array[sourceFile]);
    fread(&info_header, sizeof(info_header), 1, file_array[sourceFile]);

    fwrite(&file_header, sizeof(file_header), 1, file_array[destFile]);
    fwrite(&info_header, sizeof(info_header), 1, file_array[destFile]);

    fseek(file_array[sourceFile], 56, SEEK_SET);
    fseek(file_array[destFile], 56, SEEK_SET);
}

int menu() {
    int result;
    do {
        scanf("%d", &result);
        rewind(stdin);
    } while (result < 1 || result > 4);
    return result;
}