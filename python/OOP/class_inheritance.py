'''
child class can inherit attributes and methods from a parent class
(reusing code)
'''

## Single Inheritance : one class inherits from one parent class
class Animal:
    def speak(self):
        return "I make a sound"

class Dog(Animal):  # Dog inherits from Animal
    def speak(self):    # overwrites speak() method from Animal
        return super().speak() + " but I also say Woof!" # super() to call parent class method

d = Dog()
print(d.speak())  # Output: I make a sound but I also say Woof!


## Multiple Inheritance : a class inherits from multiple parent classes
class Animal:
    def eat(self):
        return "Eating..."

class Mammal:
    def walk(self):
        return "Walking..."

class Dog(Animal, Mammal):  # Inherits from both Animal and Mammal
    pass

my_dog = Dog()
print(my_dog.eat())  # Output: Eating...
print(my_dog.walk())  # Output: Walking...
