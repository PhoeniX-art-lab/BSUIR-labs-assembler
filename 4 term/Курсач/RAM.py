from consts import *


class RAM:
    def __init__(self, ram_info=wmi.WMI().Win32_PhysicalMemory()[0]):
        try:
            self.type = ram_types[ram_info.SMBIOSMemoryType]
        except Exception as e:
            print(e)
            self.type = 'Unknown'
        try:
            self.manufacturer = ram_info.Manufacturer
        except Exception as e:
            print(e)
            self.manufacturer = 'Unknown'
        try:
            self.capacity = int(ram_info.Capacity)/1024/1024/1024
        except Exception as e:
            print(e)
            self.capacity = 'Unknown'
        try:
            self.device_locator = ram_info.DeviceLocator
        except Exception as e:
            print(e)
            self.device_locator = 'Unknown'
        try:
            self.part_number = ram_info.PartNumber
        except Exception as e:
            print(e)
            self.part_number = 'Unknown'
        try:
            self.speed = ram_info.ConfiguredClockSpeed
        except Exception as e:
            print(e)
            self.speed = 'Unknown'
        try:
            self.bank_label = ram_info.BankLabel
        except Exception as e:
            print(e)
            self.bank_label = 'Unknown'
