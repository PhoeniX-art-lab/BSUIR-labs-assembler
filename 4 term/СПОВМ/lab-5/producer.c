#include <stdio.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <unistd.h>
#include <time.h>
#include <signal.h>
#include <semaphore.h>
#include <pthread.h>
#include <string.h>
#include <fcntl.h>

pthread_mutex_t mutexBuffer;
sem_t *semEmpty;
sem_t *semFull;
int term_flag = 1;
void term_handler(int sig);
char* rand_str();

#define MSGSZ 128
#define PRODUCER_FILE "producer.txt"

typedef struct msgbuf {
	long mtype;
	char mtext[MSGSZ];
} message_buf;

int main() {
    signal(SIGTERM, term_handler);
    srand(time(NULL));
    FILE *f;
    
    semEmpty = sem_open("/empty", 438);
    semFull = sem_open("/full", 438);

    int msqid, p_count = 0;
    size_t buf_length;
    if ((msqid = msgget(10, 0666)) == -1) {
        perror("msgget error");
        return 1;
    }
    struct timespec tw = {5,0};
    struct timespec tr;
    message_buf rbuf;
    pthread_mutex_init(&mutexBuffer, NULL);
    
    while (term_flag) {
        nanosleep(&tw, &tr);
        strcpy(rbuf.mtext, rand_str());
        buf_length = strlen(rbuf.mtext) + 1;
        sem_wait(semEmpty);
        pthread_mutex_lock(&mutexBuffer);
        f = fopen(PRODUCER_FILE, "r");
        fscanf(f, "%d", &p_count);
        fclose(f);

        if (msgsnd(msqid, &rbuf, buf_length, IPC_NOWAIT) == 0) {
            printf("\nPRODUCER: Message #%d send: %s\n",p_count, rbuf.mtext);
            printf("PRODUCER: PID: %d\n", getpid());
            p_count++;
        }
        f = fopen(PRODUCER_FILE, "w");
        fprintf(f, "%d", p_count);
        fclose(f);

        pthread_mutex_unlock(&mutexBuffer);
        sem_post(semFull);      
    }
    
    pthread_mutex_destroy(&mutexBuffer);
    return 0;
}

void term_handler(int sig) {
    term_flag = 0;
}

char* rand_str() {

	int size = rand()%50 + 2;
	char* str = calloc(size + 1, 1);

	int i = 0;
	for (i = 0; i < size; i++) {
		str[i] = (char)(rand()%26 + 97);
	}

	str[i+1] = '\0';

	return str;
}
