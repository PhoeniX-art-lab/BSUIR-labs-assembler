from consts import *


class ROM:
    def __init__(self, rom_info=wmi.WMI().Win32_DiskDrive()[0]):
        try:
            self.size = float('{:.2f}'.format(int(rom_info.Size) / 1024 / 1024 / 1024))
        except Exception as e:
            print(e)
            self.size = 'Unknown'
        try:
            self.interface_type = rom_info.InterfaceType
        except Exception as e:
            print(e)
            self.interface_type = 'Unknown'
        try:
            self.model = rom_info.Model
        except Exception as e:
            print(e)
            self.model = 'Unknown'
        try:
            self.serial_number = ''.join(rom_info.SerialNumber.split('_'))
        except Exception as e:
            print(e)
            self.serial_number = 'Unknown'
        try:
            self.additional_specifications = ''
            for i in range(len(rom_info.CapabilityDescriptions)):
                self.additional_specifications += rom_info.CapabilityDescriptions[i]
                self.additional_specifications += ', '
            self.additional_specifications = self.additional_specifications[:len(self.additional_specifications) - 2:]
        except Exception as e:
            print(e)
            self.additional_specifications = 'Unknown'
        try:
            self.manufacturer = rom_info.Manufacturer.replace('(', '').replace(')', '')
        except Exception as e:
            print(e)
            self.manufacturer = 'Unknown'
