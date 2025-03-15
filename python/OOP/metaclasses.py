'''
type() function can be used to dynamically create a class
    type(name, bases, attrs) creates a new class dynamically
'''

# Creating a class dynamically using type()
Person = type("Person", (object,), {"name": "Alice", "greet": lambda self: f"Hello, {self.name}!"})

p = Person()
print(p.greet())  # Output: "Hello, Alice!"


'''
metaclass defines how a class is created, modified, and instantiated
- it allows modifying classes at creation time
'''
class Meta(type):
    def __new__(cls, name, bases, dct):
        dct["new_attribute"] = "I am added dynamically!"
        return super().__new__(cls, name, bases, dct)

class MyClass(metaclass=Meta):
    pass

obj = MyClass()
print(obj.new_attribute)  # Output: "I am added dynamically!"


class DynamicClass:
    pass

DynamicClass.new_method = lambda self: "Dynamically added method!"
obj = DynamicClass()
print(obj.new_method())  # Output: "Dynamically added method!"
