'''
Dunder (double underscore) methods allow operator overloading
enable us to define how objects behave for built-in operations like addition etc.

common magic methods:
__init__()      constructor (initialize an object)
__str__()       string representation (print(obj))
__repr__()      unambiguous string representation
__add__()       overloads + operator
__len__()       called by len(obj)
__getitem__()   access elements like obj[index]
'''

## __str__() - string representation
class Person:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return f"Person: {self.name}"

p = Person("Alice")
print(p)  # Output: Person: Alice


## __add__() - operator overloading
class Number:
    def __init__(self, value):
        self.value = value

    def __add__(self, other):
        return Number(self.value + other.value)

n1 = Number(5)
n2 = Number(10)
result = n1 + n2
print(result.value)  # Output: 15
