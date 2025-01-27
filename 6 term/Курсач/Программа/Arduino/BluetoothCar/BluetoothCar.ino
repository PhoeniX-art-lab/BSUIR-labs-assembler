/*============= НАСТРОЙКИ =============*/
#define MOTOR_MAX 255                 // максимальный сигнал на мотор (max 255)
#define JOY_MAX 40                    // рабочий ход джойстика (из приложения)
#define minDuty 0                     // скорость, при которой мотор должен начинать крутится (обычно 25-50)
#define RIGHT_MOTOR_DIRECTION REVERSE  // напрваление правого мотора (NORMAL или REVERSE)
#define LEFT_MOTOR_DIRECTION REVERSE   // напрваление левого мотора (NORMAL или REVERSE)
#define RIGHT_MOTOR_MODE HIGH         // изменить HIGH на LOW если мотор включает тормоз
#define LEFT_MOTOR_MODE HIGH          // изменить HIGH на LOW если мотор включает тормоз

/*=============== ПИНЫ ===============*/
#define RIGHT_MOTOR_D 10
#define RIGHT_MOTOR_PWM 11            // Шим пин
#define LEFT_MOTOR_D 2
#define LEFT_MOTOR_PWM 3              // Шим пин
#define BT_TX 13
#define BT_RX 12


#include "Motor.h"
GMotor motorR(DRIVER2WIRE, RIGHT_MOTOR_D, RIGHT_MOTOR_PWM, RIGHT_MOTOR_MODE);
GMotor motorL(DRIVER2WIRE, LEFT_MOTOR_D, LEFT_MOTOR_PWM, LEFT_MOTOR_MODE);

#include <SoftwareSerial.h>
SoftwareSerial BTserial(BT_TX, BT_RX); // TX, RX

boolean doneParsing, startParsing;
int dataX, dataY;
String string_convert;

void setup() {
  #if (LEFT_MOTOR_PWM == 3 || LEFT_MOTOR_PWM == 11 || RIGHT_MOTOR_PWM == 3 || RIGHT_MOTOR_PWM == 11)
    //D3 и D11 62.5 kHz PWM
    TCCR2B = 0b00000001;
    TCCR2A = 0b00000011;
  #elif (LEFT_MOTOR_PWM == 9 || LEFT_MOTOR_PWM == 10 || RIGHT_MOTOR_PWM == 9 || RIGHT_MOTOR_PWM == 10)
    //D9 и D10 62.5 kHz PWM
    TCCR1A = 0b00000001;
    TCCR1B = 0b00001001;
  #endif

  BTserial.begin(9600);
  Serial.begin(9600);

  motorR.setMode(AUTO);
  motorL.setMode(AUTO);
  motorR.setMinDuty(minDuty);
  motorL.setMinDuty(minDuty);
  motorR.setDirection(RIGHT_MOTOR_DIRECTION);
  motorL.setDirection(LEFT_MOTOR_DIRECTION);
}

void loop() {
  parsing();         // функция парсинга

  if (doneParsing) { // если получены данные
    doneParsing = false;
    Serial.println("");
    Serial.print("Data X: ");
    Serial.println(dataX);
    Serial.print("Data Y: ");
    Serial.println(dataY);

    int joystickX = map((dataX), -JOY_MAX, JOY_MAX, -MOTOR_MAX / 2, MOTOR_MAX / 2); // сигнал по Х
    int joystickY = map((dataY), -JOY_MAX, JOY_MAX, -MOTOR_MAX, MOTOR_MAX);         // сигнал по Y

    int dutyR = joystickY + joystickX; // считаем сигнал для правого мотора
    int dutyL = joystickY - joystickX; // считаем сигнал для левого мотора

    dutyR = constrain(dutyR, -MOTOR_MAX, MOTOR_MAX); // ограничиваем значение для dutyR, на случай если dutyR > 255
    dutyL = constrain(dutyL, -MOTOR_MAX, MOTOR_MAX); // ограничиваем значение для dutyL, на случай если dutyL > 255

    motorR.smoothTick(dutyR); // плавно крутим правый мотор
    motorL.smoothTick(dutyL); // плавно крутим левый мотор
  }
}

void parsing() {
  if (BTserial.available() > 0) {       // если в буфере есть данные
    char incomingChar = BTserial.read();// читаем из буфера
    Serial.print(incomingChar);
    // Serial.println("");
    if (startParsing) {                 // начать принятие пакетов
      if (incomingChar == ' ') {        // принят пакет dataX
        dataX = string_convert.toInt(); // ковертируем принятый пакет в переменную
        // Serial.print("Data X: ");
        // Serial.println(dataX);
        string_convert = "";            // очищаем переменную пакета
      }
      else if (incomingChar == ';') {   // принят пакет dataY
        dataY = string_convert.toInt(); // ковертируем принятый пакет в переменную
        // Serial.print("Data Y: ");
        // Serial.println(dataY);
        string_convert = "";            // очищаем переменную пакета
        startParsing = false;           // закончить принятие пакетов
        doneParsing = true;             // парсинг окончен, можно переходить к движению
      } else {
        string_convert += incomingChar; // записываем  принятые данные в переменную
      }
    }
    if (incomingChar == '$') {          // начало парсинга
      startParsing = true;              // начать принятие пакетов
    }
  }
}
