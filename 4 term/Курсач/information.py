from BIOS import *
from GPU import *
from RAM import *
from ROM import *
from audio import *
from computer import *
from monitor import *
from processor import *


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
