from consts import *


class Computer:
    def __init__(self):
        try:
            self.os = wmi.WMI().Win32_OperatingSystem()[0].Caption.encode("ascii", "ignore").decode("utf-8")
        except Exception as e:
            print(e)
            self.os = 'Unknown'
        try:
            self.computer_name = platform.node()
        except Exception as e:
            print(e)
            self.computer_name = 'Unknown'
        try:
            self.username = os.environ.get('USERNAME')
        except Exception as e:
            print(e)
            self.username = 'Unknown'
        try:
            self.computer_type = platform.architecture()[0][0:2]
        except Exception as e:
            print(e)
            self.computer_type = 'Unknown'
