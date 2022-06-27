#include <stdio.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <unistd.h>
#include <time.h>
#include <signal.h>
#include <semaphore.h>
#include <pthread.h>
#include <fcntl.h>


#define CONSUMER_FILE "consumer.txt"


pthread_mutex_t mutexBuffer;
int term_flag = 1;
sem_t *semEmpty;
sem_t *semFull;
void term_handler(int sig);

typedef struct msgbuf {
    long mtype;
    char mtext[128];
} message_buf;

int main(int argc, char* argv[]) {
    int c_count = 0;
    FILE *f;
    signal(SIGTERM, term_handler);
    semEmpty = sem_open("/empty", 438);
    semFull = sem_open("/full", 438);
    int buf;
    message_buf rbuf;
    int msqid;
    if ((msqid = msgget(10, 0666)) == -1) {
        perror("msgget error");
        return 1;
    }

    struct timespec tw = {5,0};
    struct timespec tr;
    pthread_mutex_init(&mutexBuffer, NULL);
    

    while (term_flag) {
        nanosleep(&tw, &tr);
        sem_wait(semFull);
        pthread_mutex_lock(&mutexBuffer);
        f = fopen(CONSUMER_FILE, "r");
        fscanf(f, "%d", &c_count);
        fclose(f);

        if (msgrcv(msqid, &rbuf, 128, 0, 0) >= 0) {
            printf("\nCONSUMER: Message #%d recived: %s\n",c_count, rbuf.mtext);
            printf("CONSUMER: PID: %d\n", getpid());
            c_count++;
        }
        f = fopen(CONSUMER_FILE, "w");
        fprintf(f, "%d", c_count);
        fclose(f);

        pthread_mutex_unlock(&mutexBuffer);
        sem_post(semEmpty);
    }
    
    //pthread_mutex_destroy(&mutexBuffer);

    return 0;
}


void term_handler(int sig) {
    term_flag = 0;
}
