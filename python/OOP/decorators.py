''' 
decorator is a function that modified another function or method without changing its structure
it allows to dynamically add functionality to function or classes
    - enhances function behavior without modifying its code
    - implemented using @decorator_name syntax

built-in decorators:
    @staticmethod: defines static method in a class
    @classmethod: defines class method
    @property: creates a read-only property
    @functools.lru_cache: caches function results for performance

use case:
    logging (track function calls)
    authentication and authorization (check user access)
    execution timing (measure function performance)
    caching results (@functools.lru_cache)
'''

## Decorator is simply a function that
#   takes a function as an argument
#   wraps that function with additional functionality
#   returns the modified functiion
def decorator(func):
    def wrapper():
        print("Before function call")
        func()
        print("After function call")
    return wrapper

@decorator  # Applying the decorator
def say_hello():
    print("Hello!")

say_hello()
# Before function call
# Hello!
# After function call


## Decorator with Arguments
def decorator(func):
    def wrapper(*args, **kwargs):  # Accept arbitrary arguments
        print("Before function call")
        result = func(*args, **kwargs)  # Call original function
        print("After function call")
        return result
    return wrapper

@decorator
def add(x, y):
    return x + y

print(add(3, 5))
# Before function call
# After function call
# 8


# Multiple Decorators (Chaining)
def bold(func):
    def wrapper():
        return f"<b>{func()}</b>"
    return wrapper

def italic(func):
    def wrapper():
        return f"<i>{func()}</i>"
    return wrapper

@bold
@italic
def greet():
    return "Hello"

print(greet())  # Output: <b><i>Hello</i></b>


## Function Execution Timing (Real-World Use Case)
import time

def timer(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"Execution time: {end - start:.5f} seconds")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(2)
    print("Function completed")

slow_function()
# Function completed
# Execution time: 2.00012 seconds


## Authentication Check Using a Decorator
def require_auth(func):
    def wrapper(user):
        if user != "admin":
            print("Access Denied!")
            return
        return func(user)
    return wrapper

@require_auth
def secret_data(user):
    print(f"Welcome {user}, here is the secret data!")

secret_data("guest")  # Output: Access Denied!
secret_data("admin")  # Output: Welcome admin, here is the secret data!


## Class-Based Decorators (use classes instead of functions)
class Decorator:
    def __init__(self, func):
        self.func = func

    def __call__(self, *args, **kwargs):
        print("Before function call")
        result = self.func(*args, **kwargs)
        print("After function call")
        return result

@Decorator
def hello():
    print("Hello, World!")

hello()
