#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>

void sort(char **, int);
int menu();
void call_fork(pid_t *pid, int *child_count, char*, char*, char*);
extern char **environ;

int main(int argc, char *argv[], char *env[]) {
    pid_t pid;
    int child_count = 0;
    char child_name[8] = {"child-"};
    char temp[2];
    const char* path = "CHILD_PATH";
    int flag = 0;


    char **paths = (char **) calloc(1024, sizeof(char *));
    for (int size = 0; size < 1024; size++)
        paths[size] = (char *) calloc(1024, sizeof(char));

    int size = 0;
    for (; __environ[size] != NULL; size++)
        paths[size] = __environ[size];


    paths = (char **) realloc(paths, size * sizeof(char *));
    sort(paths, size);
    for (int i = 0; i < size; i++)
        puts(paths[i]);

    while (1)
        switch (menu()) {
            case 1:
                call_fork(&pid, &child_count, child_name, "+", getenv("CHILD_PATH"));
                break;
            case 2:
                for (int i = 0; env[i] != NULL; i++) {
                    for (int j = 0; j < strlen(path); j++) {
                        if (env[i][j] == path[j])
                            flag = 1;
                        else {
                            flag = 0;
                            break;
                        }
                    }
                    if (flag == 1) {
                        flag = i;
                        break;
                    }
                }
                char* real_path = env[flag];
                for (int i = 0; i < strlen(env[flag]); i++) {
                    if (env[flag][i] != '/')
                        real_path++;
                    else
                        break;
                }
                call_fork(&pid, &child_count, child_name, "*", real_path);
                break;
            case 3:
                for (int i = 0; environ[i] != NULL; i++) {
                    for (int j = 0; j < strlen(path); j++) {
                        if (environ[i][j] == path[j])
                            flag = 1;
                        else {
                            flag = 0;
                            break;
                        }
                    }
                    if (flag == 1) {
                        flag = i;
                        break;
                    }
                }
                char* real_path1 = environ[flag];
                for (int i = 0; i < strlen(environ[flag]); i++) {
                    if (environ[flag][i] != '/')
                        real_path1++;
                    else
                        break;
                }
                call_fork(&pid, &child_count, child_name, "&", real_path1);
                break;
            case 4:
                return 0;

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

int menu() {
    int result;
    do {
        printf("\nEnter:\n1 + to create a child process using getenv\n"
               "2 * to create a child process using info by third main parameter\n"
               "3 & to create a child process using extern char** environ array\n"
               "4 to exit\n>");
        scanf("%d", &result);
        rewind(stdin);
        system("clear");
    } while (result < 1 || result > 4);


    return result;
}

void call_fork(pid_t *pid, int *child_count, char* child_name, char* param, char* path) {
    char temp[3];

    if ((*pid = fork()) == -1) {
        perror("PARENT: Error in fork\n");
        exit(errno);
    }
    if (*pid == 0) {
        snprintf(temp, sizeof(temp), "%d", *child_count);
        strcat(child_name, temp);
        if (execl(
                //"/home/phoenix/CLionProjects/lab-3/cmake-build-debug/lab_3",
                path,
                child_name,
                param,
                NULL) == -1) {
            perror("PARENT: Error in execve\n");
            exit(errno);
        }
    } else{
        wait(NULL);
        (*child_count)++;
    }
}
