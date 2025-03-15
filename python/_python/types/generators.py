'''
Generator is a special type of iterator that allows to iterate over data without storing everything in memory.
Generator are written like regular functions but use the yield keyword to return data lazily, one item at a time.

A generator function uses yield instead of return. Every time yield is encountered, the function's state is saved, and it resumes from where it left off when called again.
'''

def my_generator():
    yield 1
    yield 2
    yield 3

gen = my_generator()
print(next(gen))  # Output: 1
print(next(gen))  # Output: 2
print(next(gen))  # Output: 3


# Using generator for Fibonacci numbers
def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b

fib = fibonacci(5)
print(list(fib))  # Output: [0, 1, 1, 2, 3]
