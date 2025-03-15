# PROCESS is an instance of a running program
#   * when we run ls command - a short lived process is created that displays a directories content
#   * every process in Linux is assigned a unique Process ID (PID).

# ps display information about active processes
ps aux                               # list all processes running on the system

# process states:
# R  - Running: process is actively running or ready to run
# S  - Sleeping: process is waiting for an event (e.g., waiting for user input)
# D  - Uninterruptible Sleep: process is waiting for I/O operations (cannot be interrupted).
# Z  - Zombie: process has completed but is waiting for its parent process to acknowledge termination.
# T  - Stopped: process has been stopped, usually by a signal or from a terminal (e.g., using Ctrl+Z)

ps                                   # list processes i am owner of
ps -e                                # all processes (same as 'ps aux')
ps -o                                # choose columns to output
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu # output chosen columns and sort the processes by cpu
ps -u username                       # processes owned by a specific user
ps -ef | grep process_name           # find a specific process by name
ps PID                               # shows process with specific PID
ps -e -o pid, args --forest          # show graphical view of processes tree
ps aux                               # list all processess in user oriented format
#   - USER - owner of the process
# 	- PID - process ID (identification)
# 	- CMD - exact command including options to start the process; processess in [ ] brackets are kernel processess
# /proc/[PID] - numerical subdirectory for each running process
# /proc/[PID]/fd - contains one entry for each file that the process have open

ps aux --sort=-%mem | head -10  # Show top 10 memory-consuming processes
ps aux --sort=-%cpu | head -10  # Show top 10 CPU-consuming processes
