#!/bin/bash

./my_library.sh
# This script defines a library of reusable functions. These functions can be sourced and used in other scripts.

greet() {
    echo "Hello, $1!"
}

sum() {
    local num1=$1
    local num2=$2
    echo "The sum of $num1 and $num2 is $((num1 + num2))"
}

display_date() {
    echo "Today's date is: $(date)"
}

###

./main.sh
# This script demonstrates how to use the functions defined in another script (my_library.sh)
# by sourcing the library file and calling its functions.

source ./my_library.sh  # Import the functions from my_library.sh so they can be used here.
greet "Alice"
sum 5 10
display_date
