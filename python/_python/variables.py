# VARIABLES
'''
Variables are assigned values using = operator
  - case sensitive
  - can start with letter or underscore 
  - can contain letters, numbers, and underscores

camelCase
PascalCase
snake_case

Constants don't exist natively in Python.
By convention constants are written in all UPPERCASE LETTERS
[!] They should not be changed during the execution of the program
'''

# Variable Assignment
x = 10          # Integer
y = 3.14        # Float
name = "Alice"  # String

# Constants (by convention, uppercase)
PI = 3.14159
GRAVITY = 9.8

# many values to multiple variables
x, y, z = "Orange", "Banana", "Cherry"

# one value to multiple variables
x = y = z = "Orange"

fruits = ["apple", "banana", "cherry"]
x, y, z = fruits

# create variable with global scope
global x_global
x_global = "global variable"
