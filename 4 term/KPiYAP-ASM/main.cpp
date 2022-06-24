#include <iostream>
#include <time.h>
#pragma inline
#define SIZE 10

int main() {
	float* array = new float[10];
	float buffer;
	for (int i = 0; i < SIZE; i++)
		do {
			system("cls");
			std::cout << "Input " << i + 1 << " float number: ";
			std::cin >> buffer;
			if (std::cin.good()) {
				array[i] = buffer;
				break;
			} else {
				rewind(stdin);
				std::cin.clear();
			}
		} while (true);


	clock_t start, end;
	buffer = 0;
	start = clock();
	_asm {
		finit						// Инициализация сопроцесса
		mov ecx, SIZE
		mov eax, array
		fld buffer					// Загружаем в стек результат
	l1:
		fadd[eax]
		add eax, 4
	loop l1
		fst buffer
		fwait						// Синхронизировать
	}
	end = clock();
	std::cout << "\nASM time: " << (double)(end - start) / CLK_TCK << " sec" << std::endl;
	std::cout << "Result is " << buffer << std::endl;

	buffer = 0;
	start = clock();
	for (int i = 0; i < SIZE; i++)
		buffer += array[i];
	end = clock();
	std::cout << "\nC++ time: " << (double)(end - start) / CLK_TCK << " sec" << std::endl;
	std::cout << "Result is " << buffer << std::endl;
}
