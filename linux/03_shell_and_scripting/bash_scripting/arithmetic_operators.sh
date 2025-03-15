#!/bin/bash

# Basic arithmetic operations using +, -, *, /, %
num1=10
num2=3

sum=$((num1 + num2))
difference=$((num1 - num2))
product=$((num1 * num2))
division=$((num1 / num2))
remainder=$((num1 % num2))

# using let for arithmetic operations
let sum=num1+num2
let difference=num1-num2
let product=num1*num2
let division=num1/num2
let remainder=num1%num2

# using (( )) for arithmetic operations
(( sum = num1 + num2 ))
(( difference = num1 - num2 ))
(( product = num1 * num2 ))
(( division = num1 / num2 ))
(( remainder = num1 % num2 ))
