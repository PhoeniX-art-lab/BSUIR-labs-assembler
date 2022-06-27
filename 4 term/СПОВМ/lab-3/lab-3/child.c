#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>

void standout(char **);
extern char **environ;

int main(int argc, char *argv[], char *env[]) {

    if (strcmp(argv[1], "+") == 0) {
        standout(argv);
        for (int i = 0; __environ[i] != NULL; i++)
            puts(__environ[i]);
    } else if (strcmp(argv[1], "*") == 0) {
        standout(argv);
        for (int i = 0; env[i] != NULL; i++)
            puts(env[i]);
    } else if (strcmp(argv[1], "&") == 0) {
        standout(argv);
        for (int i = 0; environ[i] != NULL; i++)
            puts(environ[i]);
    }

    return 0;
}

void standout(char *argv[]) {
    printf("CHILD: My name is %s\n", argv[0]);
    printf("CHILD: My PID id %d\n", getpid());
    printf("CHILD: My parent PID is %d\n", getppid());

    /*FILE *f;
    if(!(f = fopen("paths.txt", "r"))) {
        perror("PARENT: Error in execve\n");
        exit(errno);
    }
    char path[200];
    while (fgets(path, 200, f) != NULL)
        printf("%s", path);
    fclose(f);*/

}
