'''
System Information

detecting operating system
'''

from platform import system, release, processor

system()    # 'Linux' for Linux, 'Darwin' for macOS, 'Windows' for Windows
release()   # '4.19.104-microsoft-standard' for WSL, '19.6.0' for macOS, '10' for Windows
processor() # 'x86_64' for Linux, 'i386' for macOS, 'AMD64' for Windows
