''' Instance Variables & Methods 
Instance variables and methods belong to specific objects.
- defined inside __init__ method or within other methods using self '''

class Car:
    def __init__(self, model, year):
        self.model = model  # Instance variable
        self.year = year
    
    def display_info(self):  # Instance method
        return f"Car model: {self.model}, Year: {self.year}"

car1 = Car("Toyota", 2021)
print(car1.display_info())  # Output: Car model: Toyota, Year: 2021


''' Class variables are shared by all instances of a class.
Class methods are bound to class
- defined using @classmethod decorator '''

class Employee:
    company = "ABC Corp"  # Class variable

    def __init__(self, name, position):
        self.name = name  # Instance variable
        self.position = position

    @classmethod
    def get_company(cls):  # Class method
        return cls.company

print(Employee.get_company())  # Output: ABC Corp


'''
Static Methods behaves like normal functions.
- defined using @staticmethod decorator '''

class MathOperations:
    @staticmethod
    def add(a, b):
        return a + b

print(MathOperations.add(5, 3))  # Output: 8
