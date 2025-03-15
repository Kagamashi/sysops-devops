'''
Abstract classes define a blueprint but cannot be instantiated.

They force subclasses to implement specific methods:
- used for interfaces and enforcing rules in OOP

@abstratmethod ensures speak() must be implemented in all subclasses
prevents instantiation of incomplete classes
'''

from abc import ABC, abstractmethod

class Animal(ABC):  # Abstract Base Class
    @abstractmethod
    def speak(self):  # Abstract Method
        pass

class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

# animal = Animal()  # Error: Cannot instantiate abstract class
dog = Dog()
print(dog.speak())  # Output: "Woof!"
