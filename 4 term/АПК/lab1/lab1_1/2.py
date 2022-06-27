import serial

ser2 = serial.Serial('COM2')
a = input("Enter something to continue: ")
data = ser2.read_all()
print("Data received: ", data.decode('utf-8'))

ser2.close()
