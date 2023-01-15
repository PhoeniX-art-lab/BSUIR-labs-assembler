from consts import *


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

