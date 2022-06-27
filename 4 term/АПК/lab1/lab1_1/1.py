import serial
import time

ser1 = serial.Serial('COM1')
data = str(input("Enter еру data you want to transfer: ")).encode('utf-8')
ser1.write(data)

ser1.close()

