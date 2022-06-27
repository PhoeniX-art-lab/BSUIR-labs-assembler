#include <io.h>
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

char data[7]; // данные часов
unsigned int delayTime = 0;
                            //   сек   мин    час  день  мес   год   день недели
unsigned int registerArray[] = { 0x00, 0x02, 0x04, 0x07, 0x08, 0x09, 0x06 };
int weekday;
char* months[] = {
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
};

char* days[] = {
    "SUNDAY",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY"
};

void interrupt newTime(...);                       // Новый обработчик прерываний часов
void interrupt(*lastTime)(...);                    // Старое прерывание часов

void ShowTime();
int ConvertToDecimal(int BCD);
int convertToBCD(int decimal);
void setTime();
void MyDelay(unsigned int delayMs);
void enterTime();

int main() {
    int delay_time = 0;
    while(1) {
        system("cls");
        ShowTime();
        printf("\nEnter:\n1 - to set time\n"
            "2 - to set delay\n3 - to exit\n>");
        delay(1000);
        if (kbhit())
            switch(getch()) {
                case '1': 
                    system("cls");
                    setTime();
                    break;
                case '2':
                    system("cls");
                    printf("Enter delay(ms): " );
                    scanf("%d", &delay_time);
                    MyDelay(delay_time);
                    break;
                case '3':
                    return 0;
                default: break;
            }
    }
}

void ShowTime() {

    int i = 0;
    char temp;
    for (i = 0; i < 7; i++) {
        outp(0x70, registerArray[i]);               // Выбор адреса в памяти CMOS
        data[i] = inp(0x71);                        // Считывание значения по адресу в массив
    }

    int decimalData[7];                             // Перевод значений в десятичный вид
    for (i = 0; i < 6; i++) {
        decimalData[i] = ConvertToDecimal(data[i]);
    }
    decimalData[6] = convertToBCD(data[6]);

    // вывод на экран
    if (decimalData[2] < 10) printf("0%1d", decimalData[2]);    // Часы
        else printf("%2d", decimalData[2]);
    if (decimalData[1] < 10) printf(":0%1d", decimalData[1]);   // Минуты
        else printf(":%2d", decimalData[1]);
    if (decimalData[0] < 10) printf(":0%1d", decimalData[0]);   // Секунды
        else printf(":%2d", decimalData[0]);
    // printf("\n%2d %s 20%2d\n", decimalData[3], months[decimalData[4] - 1], decimalData[5]); // День, месяц, год
    printf("\n%s, %s %2d 20%2d\n", days[decimalData[6]], months[decimalData[4] - 1], decimalData[3], decimalData[5]);

}

int ConvertToDecimal(int BCD) {
    return ((BCD / 16 * 10) + (BCD % 16));
}

int ConvertToBCD(int decimal) {
    return ((decimal / 10 * 16) + (decimal % 10));
}

void setTime() {
    enterTime();                                    // Ввод нового времени
    disable();                                      // Запрет на прерывание

    // Проверка на доступность значений для чтения/записи
    unsigned int check;
    do {
        outp(0x70, 0xA);    // Выбор регистра А          бит 7: 1 - часы заняты(происходит обновление)
        //                                               биты 4 – 6: делитель фазы (010 — 32 768 KHz — по умолчанию)
        //                                               биты 3 – 0: выбор частоты периодического прерывания:
        //                                                  0000 — выключено
        //                                                  0011 — 122 микросекунды (минимум)
        //                                                  1111 — 500 миллисекунд
        //                                                  0110 — 976,562 микросекунды (1024 Hz)
        check = inp(0x71) & 0x80; // 0x80 - 1000 0000
    } while (check);

    // Отключение обновления часов реального времени
    outp(0x70, 0xB);                                   // Выбор регистра B
        //                                                бит 7: запрещено обновление часов (устанавливают перед
        //                                                  записью новых значений в регистры даты и часов)
        //                                                бит 6: вызов периодического прерывания (IRQ8)
        //                                                бит 5: вызов прерывания при срабатывании будильника
        //                                                бит 4: вызов прерывания по окончании обновления времени
        //                                                бит 3: включена генерация прямоугольных импульсов
        //                                                бит 2: 1/0 — формат даты и времени двоичный/BCD
        //                                                бит 1: 1/0 — 24-часовой/12-часовой режим
        //                                                бит 0: автоматический переход на летнее время в апреле и октябре
    outp(0x71, inp(0x71) | 0x80); // 0x80 - 1000 0000

    for (int i = 0; i < 7; i++) {
        outp(0x70, registerArray[i]);   // Выбор нужного значения данных
        outp(0x71, data[i]);            // Подача в регистр нужного значения
    }

    // Включение обновления часов реального времени
    outp(0x70, 0xB);                // Выбор регистра В
    outp(0x71, inp(0x71) & 0x7F);   // 0x7F - 0111 1111

    enable(); // Разрешение на прерывание
    system("cls");
}

void enterTime() {
    int enter;

    do {
        rewind(stdin);
        printf("Enter year: ");
        scanf("%i", &enter);
    } while ((enter > 100 || enter < 0));
    data[5] = ConvertToBCD(enter);
    do {
        rewind(stdin);
        printf("Enter month: ");
        scanf("%i", &enter);
    } while ((enter > 12 || enter < 1));
    data[4] = ConvertToBCD(enter);

    do {
        rewind(stdin);
        printf("Enter day: ");
        scanf("%i", &enter);
    } while ((enter > 31 || enter < 1));
    data[3] = ConvertToBCD(enter);

    do {
        rewind(stdin);
        printf("Enter weekday: ");
        scanf("%i", &enter);
    } while ((enter > 6 || enter < 0));
    data[6] = ConvertToDecimal(enter);

    do {
        rewind(stdin);
        printf("Enter hours: ");
        scanf("%i", &enter);
    } while ((enter > 23 || enter < 0));
    data[2] = ConvertToBCD(enter);

    do {
        rewind(stdin);
        printf("Enter minuts: ");
        scanf("%i", &enter);
    } while (enter > 59 || enter < 0);
    data[1] = ConvertToBCD(enter);

    do {
        rewind(stdin);
        printf("Enter seconds: ");
        scanf("%i", &enter);
    } while (enter > 59 || enter < 0);
    data[0] = ConvertToBCD(enter);
}

void MyDelay(unsigned int delayMs) {
    disable(); // запрет на прерывание

    // Установка нового обработчика прерываний
    lastTime = getvect(0x70);
    setvect(0x70, newTime);

    enable(); // Разрешение на прерывание

    // Размаскировка линии сигнала запроса от RTC
    // 0xA1 - новое значение счетчика для системного таймера
    outp(0xA1, inp(0xA1) & 0xFE); // 0xFE = 1111 1110
    // 0-й бит в 0 для разрешения прерывания от RTC 

    outp(0x70, 0xB); // выбор регистра В
    outp(0x71, inp(0x71) | 0x40); // 0x40 = 0100 0000
    // 6-й бит регистра B установлен в 1 для периодического прерывания
 
    delayTime = 0;
    while (delayTime <= delayMs);
    setvect(0x70, lastTime);
    return;
}

void interrupt newTime(...) // Новый обработчик прерываний часов
{
    delayTime++;
    lastTime();
}
