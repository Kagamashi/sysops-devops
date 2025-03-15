'''
Class is a blueprint for creating objects (instances)
it defines attributes (variables) and methods (functions) that describe the behavior of the object
    - Encapsulation: bundling data and methods together
    - Inheritance: allows one class to inherit methods from another
    - Polymorphism: allows different classes to share the same method names but behave differently
'''

class Person: # defines class Person with 'class' keyword
    count = 0
    species = "Homo sapiens" # class variable (shared across all objects)

    def __init__(self, name, age):  # constructor (initializer) initializes the object's attributes
        self.name = name  # self represents the instance of the class and is used to access its attributes
        self.age = age # instance variable (unique to each object)
        Person.count += 1

    def greet(self):  # instance method (self) operate on instance attributes
        return f"Hello, my name is {self.name} and I am {self.age} years old."
    
    @classmethod
    def total_people(cls): # class method (@classmethod) operates on class attributes
        return f"Number of people: {cls.count}" # uses cls instead of self

p1 = Person("Alice", 30) # instantiates a class by calling it like a function

print(p1.greet())  # Output: Hello, my name is Alice and I am 30 years old.
print(Person.total_people())
