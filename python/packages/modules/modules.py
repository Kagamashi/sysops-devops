'''
Module is a code library; used to break down large programs into small manageable and organized files and provides reusability of code
- dir() lists all function names (or variable names) in a module

modules can be imported and we can use their functions, classes, variables:
  import module_name: Imports the entire module.
  from module_name import specific_function_or_variable: Imports a specific function, class, or variable from a module.
  import module_name as alias: Imports the module with an alias
'''

# Importing the entire module
import math
print(math.sqrt(16))  # 4.0

# Importing specific functions from a module
from math import sqrt, pi
print(sqrt(25))  # 5.0
print(pi)  # 3.141592653589793

# Importing with an alias
import math as m
print(m.factorial(5))  # 120


''' custom module is simply a .py file '''
import custom_module

print(custom_module.greet("Alice"))
print(custom_module.add(2, 3))

''' custom package is a directory that contains multiple modules typically with __init__.py file. '''
# importing package and using it's functions in main
from custom_package import function1, function2

print(function1())
print(function2())
