# DATA TYPES
'''
text type:      str
numeric types:  int, float, complex
sequence types: list, tuple, range
mapping type:   dict
set types:      set, frozenset
boolean type:   bool
binary types:   bytes, bytearray, memoryview
none type:      NoneType
'''

# get data type
x = 5
print(type(x))

# random numbers
import random 
print(random.randrange(1, 10))


# TYPE CASTING 
'''
Typecasting (type conversion) is the proces of converting one data type to another

int()    Converts a value to an integer.
float()  Converts a value to a float.
str()    Converts a value to a string.
bool()   Converts a value to a boolean.
'''

# Boolean conversion
is_valid = bool(1)  # True (non-zero values are True)
is_empty = bool(0)  # False (0 is False)
