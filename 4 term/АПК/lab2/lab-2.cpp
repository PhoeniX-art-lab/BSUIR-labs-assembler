#include <dos.h> 

#define BUFF_WIDTH 80
#define CENTER_OFFSET 0
#define LEFT_OFFSET 50
#define REG_SCREEN_SIZE 9

struct VIDEO
{
	unsigned char symb;
	unsigned char attr;
};

void getRegisterValue();

int attribute = 0x2;	//color

void interrupt(*oldHandler08) (...);
void interrupt(*oldHandler09) (...);
void interrupt(*oldHandler0A) (...);
void interrupt(*oldHandler0B) (...);
void interrupt(*oldHandler0C) (...);
void interrupt(*oldHandler0D) (...);
void interrupt(*oldHandler0E) (...);
void interrupt(*oldHandler0F) (...);

void interrupt(*oldHandler70) (...);
void interrupt(*oldHandler71) (...);
void interrupt(*oldHandler72) (...);
void interrupt(*oldHandler73) (...);
void interrupt(*oldHandler74) (...);
void interrupt(*oldHandler75) (...);
void interrupt(*oldHandler76) (...);
void interrupt(*oldHandler77) (...);

void interrupt newHandler08(...) { getRegisterValue(); oldHandler08(); }
void interrupt newHandler09(...) { getRegisterValue(); oldHandler09(); }
void interrupt newHandler0A(...) { getRegisterValue(); oldHandler0A(); }
void interrupt newHandler0B(...) { getRegisterValue(); oldHandler0B(); }
void interrupt newHandler0C(...) { getRegisterValue(); oldHandler0C(); }
void interrupt newHandler0D(...) { getRegisterValue(); oldHandler0D(); }
void interrupt newHandler0E(...) { getRegisterValue(); oldHandler0E(); }
void interrupt newHandler0F(...) { getRegisterValue(); oldHandler0F(); }

void interrupt newHandler70(...) { getRegisterValue(); oldHandler70(); }
void interrupt newHandler71(...) { getRegisterValue(); oldHandler71(); }
void interrupt newHandler72(...) { getRegisterValue(); oldHandler72(); }
void interrupt newHandler73(...) { getRegisterValue(); oldHandler73(); }
void interrupt newHandler74(...) { getRegisterValue(); oldHandler74(); }
void interrupt newHandler75(...) { getRegisterValue(); oldHandler75(); }
void interrupt newHandler76(...) { getRegisterValue(); oldHandler76(); }
void interrupt newHandler77(...) { getRegisterValue(); oldHandler77(); }

void print(int offset, int value)
{
	char temp;

	VIDEO far* screen = (VIDEO far *)MK_FP(0xB800, 0);
	screen += CENTER_OFFSET * BUFF_WIDTH + offset;

	for (int i = 7; i >= 0; i--)
	{    
		temp = value % 2;
		value /= 2;
		screen->symb = temp + '0';
		screen->attr = attribute;
		screen++;
	}
}

void getRegisterValue() 
{

	// Регистр масок доступен через порт 21h/A1h
	print(0 + LEFT_OFFSET, inp(0x21));									// IMR Master

	// Чтобы считать регистр обслуживания нужно установить значение 0Bh в 20h/A0h
	outp(0x20, 0x0B);             
	print(REG_SCREEN_SIZE + LEFT_OFFSET, inp(0x20));					// ISR Master

	// Чтобы считать регистр запросов нужно установить значение 0Ah в 20h/A0h
	outp(0x20, 0x0A);             
	print(REG_SCREEN_SIZE * 2 + LEFT_OFFSET, inp(0x20));				// IRR Master
             
	print(BUFF_WIDTH + LEFT_OFFSET, inp(0xA1));							// IMR Slave

	outp(0xA0, 0x0B);             
	print(BUFF_WIDTH + REG_SCREEN_SIZE + LEFT_OFFSET, inp(0xA0));		// ISR Slave

	outp(0xA0, 0x0A);             
	print(BUFF_WIDTH + REG_SCREEN_SIZE * 2 + LEFT_OFFSET, inp(0xA0));	// IRR Slave
}

void init()
{
	// IRQ0-7
	oldHandler08 = getvect(0x08);       // Таймер
	oldHandler09 = getvect(0x09);       // Клавиатура
	oldHandler0A = getvect(0x0A);		// Каскадное подключение второго контроллера
	oldHandler0B = getvect(0x0B);	    // Произвольное устройство (IBM PC/AT - COM2)
	oldHandler0C = getvect(0x0C);	    // Произвольное устройство (IBM PC/AT - COM1)
	oldHandler0D = getvect(0x0D); 	    // Произвольное устройство (IBM PC/AT - LPT2 Parallel Port)
	oldHandler0E = getvect(0x0E); 	    // Произвольное устройство (IBM PC/AT - floppy disk controller)
	oldHandler0F = getvect(0x0F);	    // Произвольное устройство (IBM PC/AT - Parallel Port LPT1)

	// IRQ8-15
	oldHandler70 = getvect(0x70);		// Часы реального времени
	oldHandler71 = getvect(0x71);	    // Произвольное устройство		
	oldHandler72 = getvect(0x72);	    // Произвольное устройство
	oldHandler73 = getvect(0x73);		// Произвольное устройство или таймер
	oldHandler74 = getvect(0x74);		// Мышь PS/2 или таймер
	oldHandler75 = getvect(0x75);		// Ошибка арифметического сопроцессора;
	oldHandler76 = getvect(0x76);		// Произвольное устройство или первый контроллер ATA
	oldHandler77 = getvect(0x77);		// Произвольное устройство или второй контроллер ATA

	setvect(0x60, newHandler08);
	setvect(0x61, newHandler09);
	setvect(0x62, newHandler0A);
	setvect(0x63, newHandler0B);
	setvect(0x64, newHandler0C);
	setvect(0x65, newHandler0D);
	setvect(0x66, newHandler0E);
	setvect(0x67, newHandler0F);

	setvect(0x08, newHandler70);
	setvect(0x09, newHandler71);
	setvect(0x0A, newHandler72);
	setvect(0x0B, newHandler73);
	setvect(0x0C, newHandler74);
	setvect(0x0D, newHandler75);
	setvect(0x0E, newHandler76);
	setvect(0x0F, newHandler77);


	// Отключить обработку прерываний (CLI - Clear Interrupt flag)
	_disable();

	unsigned char mask_address = inp(0x21);

	// Master
	outp(0x20, 0x11); // ICW1    10001 [xxxx1 - Управляет использованием ICW4 (1 - будет вызвана),
					  // 		 		xxx0x - Определяет использования ведомого контроллера (0 - используется),
					  //		 	    xx0xx - Определяет размер вектора прерываний (0 - 8 байт, 1 - 4 байта),
					  //		 		x0xxx - Определяет режим срабатывания триггера (1 - по фронту, 0 - по уровню),
					  //		 		1xxxx - Всегда 1]
	outp(0x21, 0x60); // ICW2	 Устанавливает адрес вектора прерывания для IRQ0
	outp(0x21, 0x04); // ICW3	 Для ведущего отводятся 7 бит. Значения те же, что и для 1-ого

	// настройка доп режимов работы
	outp(0x21, 0x01); // ICW4	 00001 [xxxx1 - Тип процессора(1 - 8086, 0 - 8085),
					  //				xxx0x - сли 1, то автоматическое завершение прерывания EOI,
					  //				x00xx - Режим работы (00 или 01 - небуферизованный режим),
					  //				0xxxx - Определяет спецальный вложенный режим(0 - не использовать)]	 
	outp(0x21, mask_address);

	// Slave
	mask_address = inp(0xA1);
	outp(0xA0, 0x11); // ICW1
	outp(0xA1, 0x08); // ICW2	 Устанавливает адрес вектора прерывания для IRQ8
	outp(0xA1, 0x02); // ICW3	 Определяет номер выхода - 010 - выход 2
	outp(0xA1, 0x01); // ICW4
	outp(0xA1, mask_address);

	// Включить обработку прерываний (STI - Set Interrupt flag)
	_enable();
}

int main()
{
	unsigned far *fp;								// Объявляем указатель

	init();
				// | Указатель конца
	FP_SEG(fp) = _psp;								// Получаем сегмент
	FP_OFF(fp) = 0x2c;								// и смещение сегмента данных с переменными среды	
	_dos_freemem(*fp);								// чтобы его освободить

	_dos_keep(0, (_DS - _CS) + (_SP / 16) + 1);		// Оставляем резидентной, указывая первым параметром
													// код завершения, а вторым - объем памяти, который должен
													// быть зарезервирован для программы после ее завершения
	return 0;
}