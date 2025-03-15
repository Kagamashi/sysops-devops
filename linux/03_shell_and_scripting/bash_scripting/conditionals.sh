#!/bin/bash

# IF / ELIF / ELSE
# comparison operators:
#   -eq  : equal to
#   -ne  : not equal to
#   -lt  : less than
#   -gt  : greater than
#   -le  : less than or equal to
#   -ge  : greater than or equal to
num=10
if [ $num -eq 10 ]; then
    echo "The number is 10"
elif [ $num -gt 10 ]; then
    echo "The number is greater than 10"
else
    echo "The number is less than 10"
fi


# string comparison:
#   =   : equal to
#   !=  : not equal to
#   -z  : string is null (empty)
#   -n  : string is not null
str1="hello"
str2="world"
if [ "$str1" = "$str2" ]; then
    echo "The strings are equal"
else
    echo "The strings are not equal"
fi

if [ -z "$str1" ]; then
    echo "String 1 is empty"
elif [ -n "$str1" ]; then
    echo "String 1 is not empty"
fi


# file testing:
#   -f  : file exists and is a regular file
#   -d  : file exists and is a directory
#   -r  : file exists and is readable
#   -w  : file exists and is writable
#   -x  : file exists and is executable
#   -e  : file exists (regardless of type)
file="testfile.txt"
if [ -f "$file" ]; then
    echo "$file exists and is a regular file"
elif [ -d "$file" ]; then
    echo "$file is a directory"
fi


# FOR : looping over a list
# for var in list; do commands; done
for fruit in apple banana cherry; do
    echo "I like $fruit"
done

# FOR : looping over a range of numbers
# for var in {start..end}; do commands; done
for num in {1..5}; do
    echo "Number: $num"
done


# WHILE
# while [ condition ]; do commands; done
counter=1
while [ $counter -le 5 ]; do
    echo "Counter is at $counter"
    ((counter++))
done


# UNTIL
# until [ condition ]; do commands; done
counter=1
until [ $counter -gt 5 ]; do
    echo "Until loop, counter is at $counter"
    ((counter++))
done


# BREAK/CONTINUE
for num in {1..10}; do
    if [ $num -eq 5 ]; then
        echo "Breaking at $num"
        break
    fi

    if [ $num -eq 3 ]; then
        echo "Skipping number $num"
        continue
    fi
    echo "Number: $num"
done
