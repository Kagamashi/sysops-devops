#!/bin/bash

set -x  # enables debugging (prints each command before executing it)
set +x  # disables debugging

# error handling using $? for exit status
# $? contains the exit status of the last command executed (0 = success, non-zero = error)
ls non_existing_file
if [ $? -ne 0 ]; then
    echo "The last command failed with a non-zero exit status."
fi

# checking a successful command
ls .
if [ $? -eq 0 ]; then
    echo "The last command was successful."
fi

trap    # command for catching signals
# trap 'commands' SIGNAL
# common signals:
#   - SIGINT (2):   Interrupt (Ctrl+C)
#   - SIGTERM (15): Termination
#   - EXIT:         Triggered when the script exits

trap 'echo "Caught SIGINT (Ctrl+C). Exiting..."; exit' SIGINT
trap 'echo "Script terminated"; exit' SIGTERM
