## dataclasses (lightweight classes for data)
# reduces boilerplate code by automatically generating __init__, __repr__
from dataclasses import dataclass

@dataclass
class Person:
    name: str
    age: int

p = Person("Alice", 30)
print(p)  # Output: Person(name='Alice', age=30)
