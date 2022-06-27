#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<dos.h>

unsigned int notes[] = { 659, 622, 659, 622, 659, 493, 622, 523, 440 };
// unsigned int notes[] = { 659, 622, 659, 622, 659, 523, 587, 523, 440, 261, 329, 440, 493, 329, 415, 493, 523, 329, 659, 622};
unsigned int fur_elise[] = { 659, 622, 659, 622, 659, 523, 587, 523, 440, 261, 329, 440, 493, 329, 415, 493, 523, 329, 659, 622, 659, 622, 659, 523, 587, 523, 440, 261, 329, 440, 493, 329, 415, 493, 523, 329};
unsigned int note_delay = 200;

void PlaySound();
void FurElise();
void ReadStatusWords();
void CharToBin(unsigned char state, char* str);
int menu();

int main() {	

	while(1) {
		switch(menu()) {
			case 1:
				PlaySound();
				break;
			case 2:
				ReadStatusWords();
				printf("\n\nPress any key to continue: ");
				getch();
				break;
			case 3:
				FurElise();
				break;
			case 4:
				return 0;
			default:
				system("cls");
		}
	}
	return 0;
}

int menu() {
	int choice = 0;
	do {
		system("cls");
		printf("Enter\n1 - Play sound\n"
			"2 - Print channels state words\n"
			"3 - Beethoven - Fur Elise\n"
			"4 - Exit\n>");
		scanf("%d", &choice);
	} while(choice < 1 || choice > 4);

	return choice;
}

//функция считывающая слова состояния каналов
void ReadStatusWords()
{
	char* bin_state;
	unsigned char state;
	
	if (!(bin_state = (char*)calloc(9, sizeof(char)))) {
		printf("Memory allocation error");
		exit(EXIT_FAILURE);
	}

	outp(0x43, 0xE2); // Заносим управляющее слово, соответствующее команде RBC
	// (Чтение состояния канала)
	state = inp(0x40); // чтение слова состояния канала 0
	CharToBin(state, bin_state);
	printf("Channel 0x40 word: %s\n", bin_state);

	bin_state[0] = '\0';
	outp(0x43, 0xE4);
	state = inp(0x41); //чтение слова состояния канала 1
	CharToBin(state, bin_state);
	printf("Channel 0x41 word: %s\n", bin_state);	

	bin_state[0] = '\0';
	outp(0x43, 0xE8);
	state = inp(0x42); //чтение слова состояния канала 2
	CharToBin(state, bin_state);
	printf("Channel 0x42 word: %s\n", bin_state);

	free(bin_state);
	return;
}

//функция перевода в двоичный код
void CharToBin(unsigned char state, char* str)
{
	char temp;
	for (int i = 7; i >= 0; i--) {
		temp = state % 2;
		state /= 2;
		str[i] = temp + '0';
	}
	str[8] = '\0';
}

// Функция воспроизведения звуков
void PlaySound() {
	long base = 1193180; 					//максимальная частота
	long kd;
	for (int i = 0; i < 9; i++) {
		outp(0x43, 0xB6); 					//  10  11  011  0 - канал 2, операция 4, режим 3, формат 0
											// T-T-T-T-T-T-T-¬
											// ¦   ¦   ¦     ¦ ¦
											// LT+T+T+T+T+-+T+T-
											// LT- LT- L=T=- L= BCD:  0 - двоичный счет;
											//   ¦   ¦    ¦           1 - двоично-десятичный счет.
											//   ¦   ¦    ¦
											//   ¦   ¦    L===== M:   000 - Генерация прерывания IRQ0 при счетчике 0;
											//   ¦   ¦                001 - Ждущий мультивибратор;
											//   ¦   ¦                X10 - Генератор имульсов;
											//   ¦   ¦                X11 - Генератор прямоугольных импульсов;
											//   ¦   ¦                100 - Программно-зависимый одновибратор
											//   ¦   ¦                101 - Аппаратно-зависимый одновибратор
											//   ¦   ¦
											//   ¦   L========== RW:  00 - команда блокировки счетчика;
											//   ¦                    01 - чтение/запись только младшего байта;
											//   ¦                    10 - чтение/запись только старшего байта;
											//   ¦                    11 - чтение/запись младшего, затем
											//   ¦                         старшего байта.
											//   ¦              
											//   L============== SC:  00 - канал 0;
											// 						  01 - канал 1;
											// 						  10 - канал 2;
											// 						  11 - код команды RBC (чтение состояния канала).
	
		kd = base / notes[i]; 				// Вычисляем задержку для загрузки в регистр счетчика таймера
	
		// Загружаем регистр счетчика таймера
		outp(0x42, kd % 256); 				// младший байт делителя
		kd /= 256;
		outp(0x42, kd); 					//старший байт делителя

		// Включение динамика
		outp(0x61, inp(0x61) | 3); 			// Устанавливаем 2 младших бита 11
		delay(note_delay); 					// Устанавливаем длительность мс
		// Выключение динамика
		outp(0x61, inp(0x61) & 0xFC); 		// Устанавливаем 2 младших бита 00				
	}
}

void FurElise() {
	long base = 1193180;
	long kd;
	for (int i = 0; i < 36; i++) {
		outp(0x43, 0xB6); 					
		kd = base / fur_elise[i]; 				
		outp(0x42, kd % 256); 				
		kd /= 256;
		outp(0x42, kd); 			
		outp(0x61, inp(0x61) | 3); 			
		delay(note_delay); 					
		outp(0x61, inp(0x61) & 0xFC);
	}
}
