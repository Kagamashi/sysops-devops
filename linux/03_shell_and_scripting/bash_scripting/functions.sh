#!/bin/bash

greet() {
    echo "Hello, $1!"
}
greet "Alice"   # call function and pass an argument

# function with multiple arguments
sum() {
    local num1=$1
    local num2=$2
    echo "The sum of $num1 and $num2 is $((num1 + num2))"
}
sum 5 10    # call function with multiple arguments

# local & global variables
global_var="I am global"
my_function() {
    local local_var="I am local"
    echo "Inside the function: $local_var"
    echo "Inside the function: $global_var"
}

# local variable is not accessible outside the function
echo "Outside the function: $local_var"   # will not print anything
echo "Outside the function: $global_var"  # print the global variable

# return values
return_value_function() {
    local result=$(( $1 * 2 ))  # double the input argument
    echo $result                # functions in Bash return values by outputting them with echo
}
