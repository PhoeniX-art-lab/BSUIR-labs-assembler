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

# 483
# 470
