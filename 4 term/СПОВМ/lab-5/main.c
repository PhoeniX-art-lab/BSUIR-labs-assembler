#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <errno.h>
#include <semaphore.h>
#include <pthread.h>
#include <fcntl.h>

#define CONSUMER_PATH "/home/phoenix/lab-5/consumer"
#define PRODUCER_PATH "/home/phoenix/lab-5/producer"
#define PRODUCER_FILE "producer.txt"
#define CONSUMER_FILE "consumer.txt"

int p_counter = 0;
int c_counter = 0;
pid_t producers[50] = {0};
pid_t consumers[50] = {0};
pid_t pid;
sem_t *semEmpty;
sem_t *semFull;
key_t key=10;
int msgid;

int menu();
void create_producer();
void create_consumer();
void delete_producer();
void delete_consumer();
void delete_all();
void create_child(const char *);

int main() {

    msgid = msgget(key, (IPC_CREAT | 0666));
    semEmpty = sem_open("/empty", O_CREAT, 438, 10);
    semFull = sem_open("/full", O_CREAT, 438, 0);
    FILE *f = fopen(PRODUCER_FILE, "w");
    fprintf(f, "%d", 1);
    fclose(f);
    f = fopen(CONSUMER_FILE, "w");
    fprintf(f, "%d", 1);
    fclose(f);

    system("clear");
    printf("Enter:\n1 - to create producer\n"
               "2 - to create consumer\n"
               "3 - to delete producer\n"
               "4 - to delete consumer\n"
               "5 - to terminate\n>");
    while (1) {
        switch (menu()) {
            case 1:
                create_producer();
                break;
            case 2:
                create_consumer();
                break;
            case 3:
                delete_producer();
                break;
            case 4:
                delete_consumer();
                break;
            case 5:
                delete_all();
                return 0;
            default:
                system("clear");
        }
    }
}

int menu() {
    int result;
    do {
        scanf("%d", &result);
        rewind(stdin);
        // system("clear");
    } while (result < 1 || result > 5);

    return result;
}

void create_producer() {
    create_child(PRODUCER_PATH);
    producers[p_counter] = pid;
    printf("Producer %d created\n", pid);

    p_counter++;
}

void create_consumer() {
    create_child(CONSUMER_PATH);
    consumers[c_counter] = pid;
    printf("Consumer %d created\n", pid);

    c_counter++;
}

void delete_producer() {
    if (p_counter == 0) {
        printf("There are no producers\n");
        return;
    }
    printf("Deleting %d producer\n", producers[p_counter - 1]);
    p_counter--;
    kill(producers[p_counter], SIGTERM);
    producers[p_counter] = (pid_t)0;
    printf("Producers remaining: %d\n", p_counter);
}

void delete_consumer() {
    if (c_counter == 0) {
        printf("There are no consumers\n");
        return;
    }
    printf("Deleting %d consumer\n", consumers[c_counter - 1]);
    c_counter--;
    kill(consumers[c_counter], SIGTERM);
    consumers[c_counter] = (pid_t)0;
    printf("Consumers remaining: %d\n", c_counter);
}

void delete_all() {
    for (int i = 0; i < p_counter; i++)
        kill(producers[i], SIGKILL);
    for (int i = 0; i < c_counter; i++)
        kill(consumers[i], SIGKILL);

    p_counter = c_counter = 0;
    sem_destroy(semFull);
    sem_destroy(semEmpty);

    struct msqid_ds buf;
    msgctl(msgid, IPC_RMID, &buf);
    // sem_unlink("/empty");
    //sem_unlink("/full");
    printf("The program has terminated!\n");
}

void create_child(const char* child_path) {
    if ((pid = fork()) == -1) {
        perror("PARENT: Error in fork\n");
        exit(errno);
    }
    if (pid == 0) {
        if (execl(child_path, NULL) == -1) {
            perror("PARENT: Error in execve\n");
            exit(errno);
        }
    }
}
