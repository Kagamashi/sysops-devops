#!/bin/bash

# declaration
my_var="Hello, World"

# environment variables
export MY_ENV_VAR="I am an environment variable" # exported env variables are available globally

# special variables
$0          # name of the script itself
$1, $2, ... # positional parameters representing command-line arguments
$@          # all positional parameters as a list
$#          # number of positional parameters
$$          # process ID of the script
$?          # exit status of the last executed command

# variable substitution
${var}          # Basic variable substitution
${var:-default} # If the variable is not set, use the default value
${var:=default} # If the variable is not set, assign it the default value

unset my_var    # removes variable from the environment making it undefined
echo "Variable substitution: ${my_var:-'Default value'}" # my_var remains unset
my_var=${my_var:='Default value assigned'}  # assign default value to my_var if unset
echo "Variable after assignment: $my_var"

# shell expansions
echo file{A,B,C}.txt  # creates fileA.txt, fileB.txt, fileC.txt
echo {1..5}           # expands to 1 2 3 4 5
echo {a..d}           # expands to a b c d

~   # tilde expansion : expands to the home directory of the current user
