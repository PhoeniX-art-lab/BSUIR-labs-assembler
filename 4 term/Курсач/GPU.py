from consts import *


class GPU:
    def __init__(self, gpu_info=None):
        if gpu_info is None:
            gpu_info = parse_string_from_cmd('wmic path win32_VideoController get AdapterRAM, Name')
        try:
            self.gpu_text = ""
            i = 0
            while i < len(gpu_info) - 2:
                self.gpu_text += f"Name\t\t{gpu_info[i + 3]}\n" \
                                 f"Video memory\t{int(int(gpu_info[i + 2])/1024/1024)} Mb\n"
                i += 2
        except Exception as e:
            print(e)
            self.gpu_text = 'Unknown'
