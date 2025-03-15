''' 
lambda function in Python is an anonymous (unnamed) function that can have multiple inputs but only one expression
usually used for short, throwaway functions that are used once or a few times in the code

lambda arguments: expression
'''

# Regular function
def square(x):
    return x * x

print(square(5))  # Output: 25

# Equivalent lambda function
square_lambda = lambda x: x * x
print(square_lambda(5))  # Output: 25


# lambda functions are often used with functions like: map(), filter(), sorted()
# map()
numbers = [1, 2, 3, 4]
squared = list(map(lambda x: x ** 2, numbers))
print(squared)  # Output: [1, 4, 9, 16]

# filter()
numbers = [1, 2, 3, 4, 5, 6]
even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print(even_numbers)  # Output: [2, 4, 6]


# sorted()
students = [("Alice", 25), ("Bob", 20), ("Charlie", 23)]
sorted_students = sorted(students, key=lambda x: x[1])  # Sort by age
print(sorted_students)  # Output: [('Bob', 20), ('Charlie', 23), ('Alice', 25)]
