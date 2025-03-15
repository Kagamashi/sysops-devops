'''
Multiple Inheritance allows a class to inherit from more than one parent class

- Useful when combining behaviors from different classes
- Can lead to diamond problem (method resolution conflicts)

Python follow Method Resolution Order (MRO) -> left to right priority (Parent1 first)
Check MRO with print(Child.mro()) or help(Child)
'''

class Parent1:
    def greet(self):
        return "Hello from Parent1"

class Parent2:
    def greet(self):
        return "Hello from Parent2"

class Child(Parent1, Parent2):  # Inherits from both Parent1 and Parent2
    pass

obj = Child()
print(obj.greet())  # Output: "Hello from Parent1" (follows method resolution order)
