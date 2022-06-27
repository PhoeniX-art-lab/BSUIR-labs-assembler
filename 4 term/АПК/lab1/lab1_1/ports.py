import sys
import glob
import time
import serial

# def serial_ports():
#     if sys.platform.startswith('win'):
#         ports = ['COM%s' % (i + 1) for i in range(256)]
#     elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
#         ports = glob.glob('/dev/tty[A-Za-z]*')
#     else:
#         raise EnvironmentError('Unsupported platform')
#     result = []
#     for port in ports:
#         try:
#             s = serial.Serial(port)
#             s.close()
#             result.append(port)
#         except (OSError, serial.SerialException):
#             pass
#
#     return result

try:
    ser1 = serial.Serial('COM1')

    ser1.write(b'a')

    data = ser1.read_all()
    print("Data received: ", data.decode('utf-8'))
except Exception as e:
    print(e)
else:
    ser1.close()
