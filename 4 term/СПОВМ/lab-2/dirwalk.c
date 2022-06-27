#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>
#include <errno.h>
#include <ftw.h>
#include <string.h>
#include <unistd.h>

int ftw_callback(const char *fpath, const struct stat *sb, int typeflag) {
    if (FTW_F == typeflag)
        puts(fpath);
    return 0;
}

int is_there_flag(const char *options, char option) {
    for (int i = 0; options[i]; i++)
        if (option == options[i])
            return 1;

    return 0;
}

int is_only_sort(const char *options) {
    for (int i = 0; options[i]; i++)
        if (options[i] == 'f' || options[i] == 'd' || options[i] == 'l')
            return 0;
    return 1;
}

void dir_working(char *path, char *flag, char **paths) {
    static int counter = 0;
    if (chdir(path) == -1)
        return;

    char str[100];
    DIR *dir;
    struct dirent *ent;
    dir = opendir("./");

    while ((ent = readdir(dir)) != NULL) {
        if (ent->d_name[0] == '.')
            continue;

        strcpy(str, path);
        strcat(str, "/");
        strcat(str, ent->d_name);
        dir_working(str, flag, paths);

        if (is_only_sort(flag) == 0) {
            switch (ent->d_type) {
                case DT_DIR:
                    if (is_there_flag(flag, 'd')) {
                        strcpy(paths[counter], str);
                        counter++;
                    }
                    break;
                case DT_LNK:
                    if (is_there_flag(flag, 'l')) {
                        strcpy(paths[counter], str);
                        counter++;
                    }
                    break;
                case DT_REG:
                    if (is_there_flag(flag, 'f')) {
                        strcpy(paths[counter], str);
                        counter++;
                    }
                    break;
                default:
                    break;
            }
        } else {
            strcpy(paths[counter], str);
            counter++;
        }
        // printf("%s\n", str);
    }
}

void sort(char **paths, int size) {
    for (int i = 1; i < size; i++)
        for (int j = i - 1; j >= 0; j--) {
            if (strcmp(paths[j], paths[j + 1]) > 0) {
                char *str = paths[j];
                paths[j] = paths[j + 1];
                paths[j + 1] = str;
            }
        }
}

int main(int argc, char *argv[]) {
    // Блок объявление переменных
    char str[100];
    int array_len = 0;
    char **paths = (char **) calloc(256, sizeof(char *));
    for (int i = 0; i < 256; i++)
        paths[i] = (char *) calloc(256, sizeof(char));

    if (argc == 1) {
        ftw(".", ftw_callback, 16);
        return 0;
    }
    DIR *dir = opendir(argv[1]);
    if (!dir) {
        perror("opendir(""/"")");
        exit(errno);
    } else if (argc == 2) {
        chdir(argv[1]);
        getcwd(str, 100);
        dir_working(str, "-fld", paths);
        for (int i = 0; paths[i][0] != '\0'; i++)
            array_len++;
        paths = realloc(paths, (array_len) * sizeof(char *));
        for (int i = 0; i < array_len; i++)
            puts(paths[i]);
    } else if (argc == 3 && argv[2][0] == '-') {
        chdir(argv[1]);
        getcwd(str, 100);
        dir_working(str, argv[2], paths);
        for (int i = 0; paths[i][0] != '\0'; i++)
            array_len++;
        paths = realloc(paths, (array_len) * sizeof(char *));

        if (is_there_flag(argv[2], 's'))
            sort(paths, array_len);

        for (int i = 0; i < array_len; i++)
            puts(paths[i]);
    } else
        puts("Error command!\n");

    return 0;
}
