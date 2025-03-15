#!/bin/bash

# function
usage() {
    echo "Usage: $0 [-h] [-n name] [-a age] [-v]"
    echo "Options:"
    echo "  -h        Show help"
    echo "  -n name   Specify a name"
    echo "  -a age    Specify an age"
    echo "  -v        Enable verbose mode"
}

# default values
VERBOSE=0
NAME=""
AGE=""

# parsing command-line options using getopts
while getopts "hn:a:v" opt; do
    case $opt in
        h)  # Handle the help option
            usage                              # Call the usage function
            exit 0                             # Exit successfully
            ;;
        n)  # Handle the name option
            NAME=$OPTARG                      # Assign the provided name to the NAME variable
            ;;
        a)  # Handle the age option
            AGE=$OPTARG                       # Assign the provided age to the AGE variable
            ;;
        v)  # Handle the verbose option
            VERBOSE=1                         # Enable verbose mode by setting VERBOSE to 1
            ;;
        \?) # Handle invalid options
            echo "Invalid option: -$OPTARG" >&2  # Print an error message for invalid options
            usage
            exit 1                               # Exit with an error
            ;;
    esac
done

###

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

while getopts ":s:p:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ((s == 45 || s == 90)) || usage
            ;;
        p)
            p=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ]; then
    usage
fi

echo "s = ${s}"
echo "p = ${p}"
