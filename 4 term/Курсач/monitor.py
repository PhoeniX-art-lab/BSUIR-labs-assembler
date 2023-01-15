from consts import *


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
