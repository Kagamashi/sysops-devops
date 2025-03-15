# List comprehension creates a new list by transforming elements of an existing iterable

# Syntax
# [expression for item in iterable if condition] 
# newlist = [expression for item in iterable if condition == True]

# List of squares
squares = [x ** 2 for x in range(5)]
print(squares)  # [0, 1, 4, 9, 16]

# List with condition
even_numbers = [x for x in range(10) if x % 2 == 0]
print(even_numbers)  # [0, 2, 4, 6, 8]


''' Dictionary comprehension creates new dictionary by transforming elements of an iterable
Syntax: {key_expression: value_expression for item in iterable if condition} '''

# Dictionary of squares
square_dict = {x: x ** 2 for x in range(5)}
print(square_dict)  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}


''' Set comprehension creates a new set by transforming elements of an iterable
Syntax: {expression for item in iterable if condition} '''

# Set of squares
square_set = {x ** 2 for x in range(5)}
print(square_set)  # {0, 1, 4, 9, 16}
