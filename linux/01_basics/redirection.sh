stdin  # standard input: receives input (usually from the keyboard or a file)
stdout # standard output: sends normal output (usually to the screen)
stderr # standard error: sends error messages (usually to the screen)

< file                              # redirect input from "file"

> file                              # create/overwrite a file
1> file                             # redirect standard output (stdout) to "file" (overwrite)

>> file                             # create/append to a file instead of overwriting
1>> file                            # redirect stdout and append to "file"

2> errors.txt                       # redirects stderr (error messages) to "errors.txt"
2>&1                                # redirect stderr to same place as stdout
|                                   # 'pipe' - use output of the previous command as input in the next one

# /dev/null is often used to get rid of unnecessary output
grep -r 'pattern' /etc/ 2>/dev/null  # display normal output, suppress errors
grep -r 'pattern' /etc/ > /dev/null  # display errors, suppress normal output
grep -r 'pattern' /etc/ &> /dev/null # suppress both normal and error messages
