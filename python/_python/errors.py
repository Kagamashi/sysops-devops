'''
Error types:
- SyntaxError: invalid syntax
- IndentationError: incorrect indentation
- NameError: using variable that hasn't been defined
- TypeError: incorrent operation on incompatible data types
- IndexError: trying to access an index that is out of range
- ValueError: function receives an argument of the correct type but an invalid value
- KeyError: non-existent dictionary key
- AttributeError: undefined attribute of an object
- ImportError: importing a module that doesn't exists

Exception handling is used to manage and respond to runtime errors in Python
    try:       code to try (the code that may raise an exception).
    except:    runs if an exception occurs.
    else:      runs if no exception occurs.
    finally:   runs no matter what, useful for cleanup actions like closing files or releasing resources.
'''

try:
    x = int(input("Enter a number: "))
    result = 10 / x
except ValueError:
    print("That's not a valid number!")
except ZeroDivisionError:
    print("Cannot divide by zero!")
else:
    print(f"Result is {result}")  # Runs if no exception occurs
finally:
    print("Execution completed.") # Runs always, even if there's an exception


'''
assert checks if a condition is True, otherwise it raises an AssertionError
'''
# assert
x = -5
assert x > 0, "x must be positive!"  # AssertionError


# Custom exceptions can be defined by inheriting from Exception
class CustomError(Exception):
    pass

try:
    raise CustomError("This is a custom error.")
except CustomError as e:
    print(f"Caught error: {e}")


'''
raise keyword is used to explicitly raise an exceptipon (custom or built-in)
'''
# raise
def check_age(age):
    if age < 18:
        raise ValueError("Age must be at least 18.")
    return "Valid age"

try:
    check_age(16)
except ValueError as e:
    print(f"Error: {e}")
