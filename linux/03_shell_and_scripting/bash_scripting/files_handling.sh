#!/bin/bash

read    # read user input

while   # reading a file line by line using 'while' read'

# reading file line by line
while IFS= read -r line; do
    echo "Line: $line"
done < sample.txt

stdin  - File descriptor 0 (used for input)
stdout - File descriptor 1 (used for output)
stderr - File descriptor 2 (used for error messages)

# redirection
>       # stdout to a file (overwrite)
>>      # stdout to a file (append)
<       # stdin from a file
2>      # stderr to a file
2>&1    # stderr to stdout (combine output and error streams)

# redirecting stdout and stderr to a file
exec 1>output.log 2>error.log

## CUSTOM FILE DESCRIPTORS
# opening a file descriptor for a specific file
exec 3>custom_output.txt                                    # open file descriptor 3 for writing to custom_output.txt
echo "This message is written using file descriptor 3" >&3
exec 3>&-                                                   # close file descriptor 3

# check if file descriptor is closed
if ! [ -e /proc/self/fd/3 ]; then
    echo "File descriptor 3 is closed."
fi
