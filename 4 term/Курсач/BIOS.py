from consts import *


class Bios:
    def __init__(self, bios_info=wmi.WMI().Win32_BIOS()[0]):
        try:
            self.manufacturer = bios_info.Manufacturer
        except Exception as e:
            print(e)
            self.manufacturer = 'Unknown'
        try:
            self.bios_versions = ''
            for i in bios_info.BIOSVersion:
                self.bios_versions += i
                self.bios_versions += '\n\t\t\t'
        except Exception as e:
            print(e)
            self.bios_versions = 'Unknown'
