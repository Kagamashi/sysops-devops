'''
Running Shell Commands

executing shell commands from Python
'''

import subprocess # subprocess for Shell Commands (avoid os.system)
from subprocess import check_output, run

command = ""

run(command, shell=True) # run shell command   
check_output(command)    # get output from a command

output = check_output(["echo", "Hello, world!"]).decode()
print(output)  # Output: Hello, world!

subprocess.run(["ls", "-l"])  # Works on macOS/Linux
subprocess.run(["dir"], shell=True)  # Windows alternative
