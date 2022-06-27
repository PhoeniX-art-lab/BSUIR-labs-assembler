#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>

volatile struct two_words {
    int a, b;
} memory;



int better_sleep(double);
void handler(int);
void handler2(int);
void handler3(int);
void handler4(int);

int print_statistic = 1;
static struct two_words zeros = { 0, 0 }, ones = { 1, 1 };
static struct two_words temp[4];
int counter = 0;

int main() {

    signal(SIGALRM, handler);
    signal(SIGUSR1, handler2);
    signal(SIGUSR2, handler3);
    signal(SIGTERM, handler4);

    memory = zeros;
    alarm(3);
    while (1) {
        memory = zeros;
        memory = ones;
    }

}

void handler(int signum) {
    /*printf ("%d,%d\n", memory.a, memory.b);*/
    if (counter == 4) {
        counter = 0;
        alarm(3);
    } else {
        temp[counter] = memory;
        counter++;
        alarm(3);
    }
    if (print_statistic == 1) {

        printf("\nCHILD: My PID id %d\n", getpid());
        printf("CHILD: My parent PID is %d\n", getppid());

        for (int i = 0; i < 4; i++)
            printf("%d, %d\t", temp[i].a, temp[i].b);
        puts("\n");
    }


}

void handler2(int signum) {
    print_statistic = 0;
    alarm(3);
}

void handler3(int signum) {
    print_statistic = 1;
    signal(SIGALRM, handler);
    alarm(3);
}

void handler4(int signum) {
    printf("\nCHILD: My PID id %d\n", getpid());
    printf("CHILD: My parent PID is %d\n", getppid());

    for (int i = 0; i < 4; i++)
        printf("%d, %d\t", temp[i].a, temp[i].b);
    puts("\n");
    alarm(5);
}
