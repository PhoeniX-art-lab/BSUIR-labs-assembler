from consts import *


class Processor:
    def __init__(self, additional_cpu_info=wmi.WMI().Win32_Processor()[0]):
        try:
            self.manufacturer = additional_cpu_info.Manufacturer
        except Exception as e:
            print(e)
            self.manufacturer = 'Unknown'
        try:
            self.caption = additional_cpu_info.Caption
        except Exception as e:
            print(e)
            self.caption = 'Unknown'
        try:
            self.name = additional_cpu_info.Name
        except Exception as e:
            print(e)
            self.name = 'Unknown'
        try:
            self.frequency = additional_cpu_info.MaxClockSpeed
        except Exception as e:
            print(e)
            self.frequency = 'Unknown'
        try:
            self.cores_number = additional_cpu_info.NumberOfCores
        except Exception as e:
            print(e)
            self.cores_number = 'Unknown'
        try:
            self.threads_number = additional_cpu_info.ThreadCount
        except Exception as e:
            print(e)
            self.threads_number = 'Unknown'
        try:
            self.bit_depth = additional_cpu_info.AddressWidth
        except Exception as e:
            print(e)
            self.bit_depth = 'Unknown'
        try:
            self.flags = self.create_flags()
        except Exception as e:
            print(e)
            self.flags = 'Unknown'
        try:
            self.l2_cache = int(int(additional_cpu_info.L2CacheSize) / 1024)
        except Exception as e:
            print(e)
            self.l2_cache = 'Unknown'
        try:
            self.l3_cache = int(int(additional_cpu_info.L3CacheSize) / 1024)
        except Exception as e:
            print(e)
            self.l3_cache = 'Unknown'

    def create_flags(self, cpu_info=cpuinfo.get_cpu_info()) -> str:
        i = 0
        flags = cpu_info['arch']
        flags += ', '
        while i < len(cpu_info['flags']):
            temp = ','.join(cpu_info['flags'][i:i + 1:])
            if temp in most_popular_instruction_sets:
                flags += temp
                flags += ', '
            if len(flags) and i == 50 > 15:
                flags += "\n\t\t\t"
            i += 1
        flags = flags[:len(flags) - 2:]
        return flags

