import os.path

from information import *

win = tk.Tk()


class StartOptions:
    def __init__(self):
        logo = tk.PhotoImage(file=LOGO)
        win.iconphoto(False, logo)
        win.config(bg=BG_COLOR)
        win.title('CPU-Go')
        win.wm_attributes('-alpha', 0.9)
        win.geometry(f'{WIN_WIDTH}x{WIN_HEIGHT}+{WIN_TOP_OFFSET}+{WIN_BOTTOM_OFFSET}')
        win.resizable(False, False)


class Frame:
    def __init__(self):
        self.info_frame = tk.Frame(win, bg=FRAME_COLOR, bd=5)
        self.info_frame.place(relx=0.13, rely=0.03, relwidth=0.8, relheight=0.9)


class Button(Frame, Information):
    def __init__(self):
        Frame.__init__(self)
        Information.__init__(self)
        self.computer_btn = tk.Button(win, text='Computer', command=self.show_computer_info, width=BUTTON_WIDTH).place(x=5, y=17)
        self.processor_btn = tk.Button(win, text='Processor', command=self.show_processor_info, width=BUTTON_WIDTH).place(x=5, y=47)
        self.RAM_btn = tk.Button(win, text='RAM', command=self.show_ram_info, width=BUTTON_WIDTH).place(x=5, y=77)
        self.ROM_btn = tk.Button(win, text='ROM', command=self.show_rom_info, width=BUTTON_WIDTH).place(x=5, y=107)
        self.GPU_btn = tk.Button(win, text='GPU', command=self.show_gpu_info, width=BUTTON_WIDTH).place(x=5, y=137)
        self.monitor_btn = tk.Button(win, text='Monitor', command=self.show_monitor_info, width=BUTTON_WIDTH).place(x=5, y=167)
        self.audio_btn = tk.Button(win, text='Audio', command=self.show_audio_info, width=BUTTON_WIDTH).place(x=5, y=197)
        self.bios_btn = tk.Button(win, text='BIOS', command=self.show_bios_info, width=BUTTON_WIDTH).place(x=5, y=227)
        self.generate_report_btn = tk.Button(win, text='Report', command=self.generate_report, width=BUTTON_WIDTH).place(x=5, y=557)

    def show_computer_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.computer_text, bg=FRAME_COLOR, font='Arial 13', fg='white',
                 justify='left').pack()

    def show_processor_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.cpu_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

    def show_ram_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.ram_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

    def show_rom_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.rom_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

    def show_gpu_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.gpu_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

    def show_monitor_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.monitor_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

    def show_audio_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.audio_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

    def show_bios_info(self):
        for widget in self.info_frame.winfo_children():
            widget.destroy()
        tk.Label(self.info_frame, text=self.bios_text, bg=FRAME_COLOR, font='Arial 13', fg='white', justify='left').pack()

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
