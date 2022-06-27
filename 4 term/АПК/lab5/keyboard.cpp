#include <io.h>
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

int exit_flag = 0;

void interrupt(*old9)(...);
void interrupt new9(...);

void indicator(int mask);
int menu();

int main() {
	while (1) {
		switch(menu()) {
			case 1:
				indicator(4); 					// вкл. индикатор Caps Lock
				delay(600);
				indicator(0); 					// выкл. все индикаторы
				delay(600);
				break;
			case 2:
				exit_flag = 0;
				old9 = getvect(0x09); 				// сохраняем указатель на старый обработчик
				setvect(0x09, new9); 				// меняем его на новый
				printf("Press ESC to enter the menu\nPress any key: ");
				while (!exit_flag) {

				}
				indicator(0); 						// выкл. все индикаторы
				setvect(0x09, old9); 				// возвращаем старый обработчик
				break;
			case 3:
				return 0;
		}
	}

	return 0;
}

void interrupt new9(...) {
	char temp[5];
	unsigned char c = inp(0x60); 		// считываем скан-код из порта клавиатуры
	if (c == 0x01) exit_flag = 1; 		// если это ESC устанавливаем флаг завершения программы
	if (c != 0xFA && !exit_flag) { 		// иначе выводим скан-код в шестнадцатиричной форме
		itoa(c, temp, 16);
		cputs("0x");
		cputs(temp);
		cputs(" ");
	}
	(*old9)();
}

void indicator(int mask) {
	// Перед отправлением маски отправляем код 0xED
	if (mask != 0xED) indicator(0xED);	//0xED - функция для управления светодиодами клавиатуры(включить, выключение)
	int i = 0;
	// Ждем подтверждения, что внутренняя очередь команд процессора клавиатуры пуста (считываем слово состояния)
	while((inp(0x64) & 2) != 0); 		// 1 бит должен быть 0
	// Регистр состояния 64h: 1 бит - наличие данных во входном буфере клавиатуры(0 - нет, 1 - есть)

	// Отправляем маску в порт клавиатуры
	do {
		i++;
		outp(0x60, mask);
	} while (inp(0x60) == 0xFE && i < 3); // Проверяем код возврата 0xFA - успешно, 0xFE - необходима повторная отправка
}

int menu() {
	int result;
	do {
		system("cls");
		printf("Enter:\n1 - to blink Caps Lock\n2 - to read return code\n3 - to exit\n>");
		scanf("%d", &result);
		rewind(stdin);
	} while (result < 1 || result > 3);

	return result;
}