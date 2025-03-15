'''
Factory Pattern is used to create objects without exposing the instantiation logic

Useful when:
- the object creation process is complex
- we need to return a specific implementation of an interface

✅ Encapsulates object creation
✅ Supports multiple implementations
'''

class Animal:
    def speak(self):
        pass

class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

class AnimalFactory:
    @staticmethod
    def create_animal(animal_type):
        if animal_type == "dog":
            return Dog()
        elif animal_type == "cat":
            return Cat()
        else:
            raise ValueError("Unknown animal type")

animal = AnimalFactory.create_animal("dog")
print(animal.speak())  # Output: "Woof!"
