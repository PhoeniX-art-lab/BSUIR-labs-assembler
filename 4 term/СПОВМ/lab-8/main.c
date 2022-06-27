#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include <semaphore.h>

#define THREAD_NUM 10

typedef struct queue queue;
struct queue {
    int data;
    struct queue* next;
};

sem_t semEmpty;
sem_t semFull;

pthread_mutex_t pthreadMutex;

// int buffer[10];
int counter = 0;
queue *head = NULL, *tail = NULL;

_Noreturn void *producer(void *);
_Noreturn void *consumer(void *);
void insert(int);
int output();

int menu();

int main() {
    srand(time(NULL));
    pthread_t producer_t[THREAD_NUM];
    pthread_t consumer_t[THREAD_NUM];
    pthread_mutex_init(&pthreadMutex, NULL);
    sem_init(&semEmpty, 0, 10);
    sem_init(&semFull, 0, 0);

    int prod = 0;
    int cons = 0;
    printf("Enter:\n1 - to create producer\n"
           "2 - to create consumer\n"
           "3 - to delete producer\n"
           "4 - to delete consumer\n"
           "5 - to terminate\n>");
    while (1) {
        switch (menu()) {
            case 1:
                if (pthread_create(&producer_t[prod], NULL, &producer, NULL) != 0)
                    perror("Failed to create thread");
                prod++;
                break;
            case 2:
                if (pthread_create(&consumer_t[cons], NULL, &consumer, NULL) != 0)
                    perror("Failed to create thread");
                cons++;
                break;
            case 3:
                if (prod > 0) {
                    if (pthread_cancel(producer_t[prod - 1]) != 0){
                        perror("Failed to cancel thread");
                        break;
                    }
                    printf("Deleting producer #%d\n", prod - 1);
                    prod--;
                } else
                    printf("There are no producers\n");
                break;
            case 4:
                if (cons > 0) {
                    if (pthread_cancel(consumer_t[cons - 1]) != 0) {
                        perror("Failed to cancel thread");
                        break;
                    }
                    printf("Deleting consumer #%d\n", cons - 1);
                    cons--;
                } else
                    printf("There are no consumers\n");
                break;
            case 5:
                for (int i = 0; i < prod; i++)
                    if (pthread_detach(producer_t[i]) != 0)
                        perror("Failed to detach thread");
                for (int i = 0; i < cons; i++)
                    if (pthread_detach(consumer_t[i]) != 0)
                        perror("Failed to detach thread");
                sem_destroy(&semEmpty);
                sem_destroy(&semFull);
                pthread_mutex_destroy(&pthreadMutex);
                return 0;
        }
    }
}

_Noreturn void *producer(void *arg) {
    while (1) {
        int rand_number = rand() % 100;
        sleep(3);

        sem_wait(&semEmpty);
        pthread_mutex_lock(&pthreadMutex);
        // buffer[counter] = rand_number;
        insert(rand_number);
        printf("PRODUCER: Put %d\n", rand_number);
        counter++;
        pthread_mutex_unlock(&pthreadMutex);
        sem_post(&semFull);
    }
}

_Noreturn void *consumer(void *arg) {
    while (1) {
        int number;
        sem_wait(&semFull);
        pthread_mutex_lock(&pthreadMutex);
//        number = buffer[0];
//        for (int i = 0; i < counter - 1; i++)
//            buffer[i] = buffer[i + 1];
        number = output();

        counter--;
        pthread_mutex_unlock(&pthreadMutex);
        sem_post(&semEmpty);

        printf("CONSUMER: Got %d\n", number);
        sleep(3);
    }
}

int menu() {
    int result;
    do {
        scanf("%d", &result);
        rewind(stdin);
    } while (result < 1 || result > 5);

    return result;
}

void insert(int data) {
    struct queue* temp = (queue*)calloc(1, sizeof(queue));
    temp->data = data;
    if (!head)
        head = tail = temp;
    else {
        (tail)->next = temp;
        tail = temp;
    }
}

int output() {
    int result = head->data;
    struct queue* temp;
    temp = head;
    head = head->next;
    free(temp);

    return result;
}
