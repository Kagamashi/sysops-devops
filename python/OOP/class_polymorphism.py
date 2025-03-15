'''
different classes can share the same method but behave differently
(same interface, different implementation)
'''

class Cat:
    def speak(self):
        return "Meow!"

class Dog:
    def speak(self):
        return "Woof!"

# Polymorphism
animals = [Cat(), Dog()]
for animal in animals:
    print(animal.speak())

# Meow!
# Woof!
