import wmi
import tkinter as tk
import subprocess
from win32api import GetSystemMetrics

# print(platform.uname())
# current_major_version = wmi.WMI().Win32_OperatingSystem()[0].Caption.encode("ascii", "ignore").decode("utf-8")
# print(current_major_version)
# print(os.environ.get("USERNAME"))
# print(platform.architecture())
# print(cpuinfo.get_cpu_info())

# print(wmi.WMI().Win32_DiskDrive()[0])             # ROM
# print(wmi.WMI().Win32_OperatingSystem()[0])       # OS
# print(wmi.WMI().Win32_VideoController()[0])       # GPU
# print(wmi.WMI().Win32_BaseBoard()[0])             # Base Board
# print(wmi.WMI().Win32_DesktopMonitor()[0])        # Monitor
# print(wmi.WMI().Win32_Processor()[0])             # CPU
# print(wmi.WMI().CIM_VideoControllerResolution()[0])
# print(wmi.WMI().CIM_VideoSetting()[0])
# print(wmi.WMI().Win32_SoundDevice()[0])            # Audio
# print(wmi.WMI().Win32_BIOS()[0])                    # BIOS


# direct_output = subprocess.check_output('powershell [uint64]"0x180000000"/1073741824', shell=True).decode('utf-8')
# print(direct_output)

# direct_output = subprocess.check_output('wmic path win32_VideoController get AdapterRAM, Name', shell=True)
# res = ''
# for i in range(len(direct_output)):
#     res += chr(direct_output[i])
#
# print(res)
# res = res.split('  ')
# for i in range(len(res)):
#     res[i] = res[i].replace('\r', '')
#     res[i] = res[i].replace('\n', '')
#     res[i] = res[i].replace(' ', '')
# while True:
#     try:
#         res.remove('')
#     except ValueError:
#         break
#
# print(res)
import tkinter as tk
import platform
import wmi
import os
from ctypes import *
import cpuinfo
import subprocess

WIN_WIDTH = 800
WIN_HEIGHT = 600
WIN_TOP_OFFSET = 470
WIN_BOTTOM_OFFSET = 150
BG_COLOR = '#3c3f41'
FRAME_COLOR = '#212121'
LOGO = 'Logo.png'
REPORT_FILE_NAME = 'Report'
BUTTON_WIDTH = 10
most_popular_instruction_sets = ['mmx', 'sse', 'sse2', 'sse4_1', 'sse4_2', 'sse4a', 'sse3', 'avx', 'avx2', 'fma', 'aes',
                                 'sha']

ram_types = {
    0: "Unknown",
    1: "Other",
    2: "DRAM",
    3: "Synchronous DRAM",
    4: "Cache DRAM",
    5: "EDO",
    6: "EDRAM",
    7: "VRAM",
    8: "SRAM",
    9: "RAM",
    10: "ROM",
    11: "FLASH",
    12: "EEPROM",
    13: "FEPROM",
    14: "EPROM",
    15: "CDRAM",
    16: "3DRAM",
    17: "SDRAM",
    18: "SGRAM",
    19: "RDRAM",
    20: "DDR",
    21: "DDR2",
    22: "DDR2 FB-DIMM",
    23: "DDR2—FB-DIMM",
    24: "DDR3",
    25: "FBD2",
    26: "DDR4"
}

sound_status = {
    1: "Other",
    2: "Unknown",
    3: "Enabled",
    4: "Disabled",
    5: "Not Applicable"
}


def parse_string_from_cmd(command: str) -> list:
    direct_output = subprocess.check_output(command, shell=True)
    res = ''
    for i in range(len(direct_output)):
        res += chr(direct_output[i])

    res = res.split('  ')
    for i in range(len(res)):
        res[i] = res[i].replace('\r', '')
        res[i] = res[i].replace('\n', '')
        res[i] = res[i].replace(' ', '')
    while True:
        try:
            res.remove('')
        except ValueError:
            break
    return res


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
            self.capacity = int(ram_info.Capacity) / 1024 / 1024 / 1024
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


class GPU:
    def __init__(self, gpu_info=None):
        if gpu_info is None:
            gpu_info = parse_string_from_cmd('wmic path win32_VideoController get AdapterRAM, Name')
        try:
            self.gpu_text = ""
            i = 0
            while i < len(gpu_info) - 2:
                self.gpu_text += f"Name\t\t{gpu_info[i + 3]}\n" \
                                 f"Video memory\t{int(int(gpu_info[i + 2]) / 1024 / 1024)} Mb\n"
                i += 2
        except Exception as e:
            print(e)
            self.gpu_text = 'Unknown'


class Monitor:
    def __init__(self, monitor_info=wmi.WMI().Win32_DesktopMonitor()[0], display_info=None, freshrate=None):
        if freshrate is None:
            freshrate = parse_string_from_cmd('wmic PATH Win32_videocontroller get currentrefreshrate')
        if display_info is None:
            display_info = parse_string_from_cmd(
                'wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution')
        try:
            self.caption = monitor_info.Caption
        except Exception as e:
            print(e)
            self.caption = 'Unknown'
        try:
            self.width = display_info[2]
        except Exception as e:
            print(e)
            self.width = 'Unknown'
        try:
            self.height = display_info[3]
        except Exception as e:
            print(e)
            self.height = 'Unknown'
        try:
            self.screen_resolution = freshrate[-1]
        except Exception as e:
            print(e)
            self.screen_resolution = 'Unknown'


class Audio:
    def __init__(self, audio_inf=wmi.WMI().Win32_SoundDevice()[0]):
        try:
            self.caption = audio_inf.Caption
        except Exception as e:
            print(e)
            self.caption = 'Unknown'
        try:
            self.status = sound_status[int(audio_inf.StatusInfo)]
        except Exception as e:
            print(e)
            self.status = 'Unknown'
        try:
            self.manufacturer = audio_inf.Manufacturer
        except Exception as e:
            print(e)
            self.manufacturer = 'Unknown'


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


class Information:
    def __init__(self):
        # Computer
        self.computer = Computer()
        self.computer_text = f"Operating system\t\t{self.computer.os}\n" \
                             f"Computer name   \t\t{self.computer.computer_name}\n" \
                             f"Username        \t\t{self.computer.username}\n" \
                             f"Computer type   \t\tx{self.computer.computer_type}-based PC\n"

        # Processor
        self.processor = Processor()
        self.cpu_text = f"CPUID manufacturer\t{self.processor.manufacturer}\n" \
                        f"Caption\t\t\t{self.processor.caption}\n" \
                        f"CPU name\t\t{self.processor.name}\n" \
                        f"CPU frequency\t\t{self.processor.frequency} MHz\n" \
                        f"Cores number\t\t{self.processor.cores_number}\n" \
                        f"Threads number\t\t{self.processor.threads_number}\n" \
                        f"Processor bit depth\t\tx{self.processor.bit_depth}\n" \
                        f"Instruction sets\t\t{self.processor.flags}\n" \
                        f"L2 Cache size\t\t{self.processor.l2_cache} Mb\n" \
                        f"L3 Cache size\t\t{self.processor.l3_cache} Mb\n"

        # RAM
        self.ram = RAM()
        self.ram_text = f"Memory type\t\t{self.ram.type}\n" \
                        f"Manufacturer\t\t{self.ram.manufacturer}\n" \
                        f"Capacity\t\t\t{self.ram.capacity} Gb\n" \
                        f"Device Locator\t\t{self.ram.device_locator}\n" \
                        f"Part number\t\t{self.ram.part_number}\n" \
                        f"Speed\t\t\t{self.ram.speed} MHz\n" \
                        f"Bank Label\t\t{self.ram.bank_label}\n"

        # ROM
        self.rom = ROM()
        self.rom_text = f"Size\t\t\t{self.rom.size} Gb\n" \
                        f"Interface type\t\t{self.rom.interface_type}\n" \
                        f"Model\t\t\t{self.rom.model}\n" \
                        f"Serial number\t\t{self.rom.serial_number}\n" \
                        f"Additional specifications\t{self.rom.additional_specifications}\n" \
                        f"Manufacturer\t\t{self.rom.manufacturer}\n"

        # GPU
        self.gpu = GPU()
        self.gpu_text = self.gpu.gpu_text

        # Monitor
        self.monitor = Monitor()
        self.monitor_text = f"Caption\t\t\t{self.monitor.caption}\n" \
                            f"Display width\t\t{self.monitor.width} px\n" \
                            f"Display height\t\t{self.monitor.height} px\n" \
                            f"Screen resolution\t\t{self.monitor.screen_resolution} Hz\n"

        # Audio
        self.audio = Audio()
        self.audio_text = f"Caption\t\t\t{self.audio.caption}\n" \
                          f"Status\t\t\t{self.audio.status}\n" \
                          f"Manufacturer\t\t{self.audio.manufacturer}\n"

        # BIOS
        self.bios = Bios()
        self.bios_text = f"BIOS manufacturer\t\t{self.bios.manufacturer}\n" \
                         f"BIOS versions\t\t{self.bios.bios_versions}\n"


win = tk.Tk()


class StartOptions:
    def __init__(self):
        logo = tk.PhotoImage(file=LOGO)
        win.iconphoto(False, logo)
        win.config(bg=BG_COLOR)
        win.title('SICU_Smartbit')
        win.wm_attributes('-alpha', 0.9)
        win.geometry(f'{WIN_WIDTH}x{WIN_HEIGHT}+{WIN_TOP_OFFSET}+{WIN_BOTTOM_OFFSET}')
        win.resizable(True, True)


class Frame:
    def __init__(self):
        self.info_frame = tk.Frame(win, bg=FRAME_COLOR, bd=5)
        self.info_frame.place(relx=0.13, rely=0.03, relwidth=0.8, relheight=0.9)


class Button(Frame, Information):
    def __init__(self):
        Frame.__init__(self)
        Information.__init__(self)
        self.computer_btn = tk.Button(win, text='Computer', command=self.show_computer_info, width=BUTTON_WIDTH).place(
            x=5, y=17)
        self.processor_btn = tk.Button(win, text='Processor', command=self.show_processor_info,
                                       width=BUTTON_WIDTH).place(x=5, y=47)
        self.RAM_btn = tk.Button(win, text='RAM', command=self.show_ram_info, width=BUTTON_WIDTH).place(x=5, y=77)
        self.ROM_btn = tk.Button(win, text='ROM', command=self.show_rom_info, width=BUTTON_WIDTH).place(x=5, y=107)
        self.GPU_btn = tk.Button(win, text='GPU', command=self.show_gpu_info, width=BUTTON_WIDTH).place(x=5, y=137)
        self.monitor_btn = tk.Button(win, text='Monitor', command=self.show_monitor_info, width=BUTTON_WIDTH).place(x=5,
                                                                                                                    y=167)
        self.audio_btn = tk.Button(win, text='Audio', command=self.show_audio_info, width=BUTTON_WIDTH).place(x=5,
                                                                                                              y=197)
        self.bios_btn = tk.Button(win, text='BIOS', command=self.show_bios_info, width=BUTTON_WIDTH).place(x=5, y=227)
        self.generate_report_btn = tk.Button(win, text='Report', command=self.generate_report,
                                             width=BUTTON_WIDTH).place(x=5, y=557)

    def show_computer_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.computer_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_processor_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.cpu_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_ram_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.ram_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_rom_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.rom_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_gpu_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.gpu_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_monitor_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.monitor_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_audio_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.audio_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_bios_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.bios_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def generate_report(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        i = 1
        while os.path.exists(f"{REPORT_FILE_NAME}-{i}.txt"):
            i += 1
        report_file = open(f"{REPORT_FILE_NAME}-{i}.txt", "w+")
        report_file.write(self.computer_text)
        report_file.write(self.cpu_text)
        report_file.write(self.ram_text)
        report_file.write(self.rom_text)
        report_file.write(self.gpu_text)
        report_file.write(self.monitor_text)
        report_file.write(self.audio_text)
        report_file.write(self.bios_text)
        tk.Label(self.info_frame, text='Report generated successfully', bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()


StartOptions()
Frame()
Button()
try:
    windll.shcore.SetProcessDpiAwareness(c_int(1))
except Exception as e:
    print(e)
win.mainloop()
