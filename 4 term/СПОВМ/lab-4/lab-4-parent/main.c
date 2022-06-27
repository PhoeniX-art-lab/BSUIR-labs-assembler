#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <stdlib.h>

int menu();
void call_fork(pid_t*, char*);

int main() {
    pid_t pid;
    const char *path = "CHILD_PATH";
    int pid_counter = 0;
    int temp;
    pid_t *startedProcesses = NULL;
//    pid_t *startedProcesses = (pid_t*)calloc(1, sizeof(pid_t));


    while (1) {
        switch (menu()) {
            case 1:
                call_fork(&pid, getenv(path));
                startedProcesses = (pid_t*) realloc(startedProcesses, (pid_counter + 1)*sizeof(pid_t));
                startedProcesses[pid_counter] = pid;
                pid_counter++;
                break;
            case 2:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                printf("\nDeleting CHILD %d.", startedProcesses[pid_counter - 1]);
                pid_counter--;
                kill(startedProcesses[pid_counter], SIGKILL);
                startedProcesses = (pid_t*) realloc(startedProcesses, (pid_counter)*sizeof(pid_t));
                printf(" Child's remaining: %d\n", pid_counter);
                break;
            case 3:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                for (int i = 0; i < pid_counter; i++){
                   kill(startedProcesses[i], SIGKILL);
                }
                pid_counter = 0;
                printf("\nAll CHILD's deleted!\n");
                break;
            case 4:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                for (int i = 0; i < pid_counter; i++){
                    kill(startedProcesses[i], SIGUSR1);
                }
                break;
            case 5:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                for (int i = 0; i < pid_counter; i++)
                    kill(startedProcesses[i], SIGUSR2);
                break;
            case 6:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                for (int i = 0; i < pid_counter; i++)
                    kill(startedProcesses[i], SIGSTOP);
                do {
                    printf("Enter number of process that you want to prohibit display statistics: ");
                    scanf("%d", &temp);
                    rewind(stdin);
                    system("clear");
                    temp--;
                } while (temp < 0 || temp >= pid_counter);
                kill(startedProcesses[temp], SIGUSR1);
                for (int i = 0; i < pid_counter; i++)
                    kill(startedProcesses[i], SIGCONT);
                break;
            case 7:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                for (int i = 0; i < pid_counter; i++)
                    kill(startedProcesses[i], SIGSTOP);
                do {
                    printf("Enter number of process that you want to allow display statistics: ");
                    scanf("%d", &temp);
                    rewind(stdin);
                    system("clear");
                    temp--;
                } while (temp < 0 || temp >= pid_counter);
                kill(startedProcesses[temp], SIGUSR2);
                for (int i = 0; i < pid_counter; i++)
                    kill(startedProcesses[i], SIGCONT);
                break;
            case 8:
                if (pid_counter == 0) {
                    puts("\nThere are no processes!\n");
                    break;
                }
                for (int i = 0; i < pid_counter; i++){
                    kill(startedProcesses[i], SIGUSR1);
                }
                do {
                    printf("Enter number of process that you want to output statistics: ");
                    scanf("%d", &temp);
                    rewind(stdin);
                    system("clear");
                    temp--;
                } while (temp < 0 || temp >= pid_counter);
                kill(startedProcesses[temp], SIGTERM);
                sleep(1);
                for (int i = 0; i < pid_counter; i++){
                    kill(startedProcesses[i], SIGUSR2);
                }
                break;
            case 9:
                for (int i = 0; i < pid_counter; i++){
                    kill(startedProcesses[i], SIGKILL);
                }
            case 10: return 0;
            default:
                system("clear");
        }
    }

}

int menu() {
    int result;
    do {
        printf("\nEnter:\n1 + to create a child process\n"
               "2 - to delete last process and list remaining\n"
               "3 k to delete all child's\n"
               "4 s to prohibit everyone display statistics\n"
               "5 g to allow everyone to display statistics\n"
               "6 s<num> to prohibit <num> display statistics\n"
               "7 g<num> to allow <num> display statistics\n"
               "8 p<num> output <num> statistics. Enable everyone display statistics\n"
               "9 q to delete all child's and exit\n"
               "10 to exit\n>");
        scanf("%d", &result);
        rewind(stdin);
        system("clear");
    } while (result < 1 || result > 10);


    return result;
}

void call_fork(pid_t *pid, char* path) {
    if ((*pid = fork()) == -1) {
        perror("PARENT: Error in fork\n");
        exit(errno);
    } if (*pid == 0) {
        if (execl(path,NULL) == -1) {
            perror("PARENT: Error in execve\n");
            exit(errno);
        }
    }

}



