'''
Type Hints in Python is a way to specify expected data types for variables, function parameters, and return values.

- use ':' (colon) syntax to define type hints
- '->' to define function return type

Type hints do NOT enforce types at runtime, but help tools like mypy detect errors.
'''

# Variables:
x: int = 10
name: str = "Alice"
is_valid: bool = True
pi: float = 3.1415


# Function parameters:
# a: int, b: int - parameters should be integers
def add(a: int, b: int) -> int: # -> int - function returns an integer
    return a + b
def greet(name: str) -> str:
    return f"Hello, {name}!"


# for collections import type hints from typing module
from typing import List, Tuple, Dict, Set
numbers: List[int] = [1, 2, 3]  # List of integers
coordinates: Tuple[float, float] = (10.5, 20.3)  # Tuple of two floats
user_info: Dict[str, int] = {"Alice": 30, "Bob": 25}  # Dictionary with string keys and int values
unique_ids: Set[int] = {101, 102, 103}  # Set of integers


# Optional[type] when parameter can be None
from typing import Optional
def get_username(user_id: int) -> Optional[str]:
    if user_id == 1:
        return "Alice"
    return None  # `None` is allowed


# Union[A, B] for allowing multiple types
from typing import Union

def process_data(data: Union[int, str]) -> str:
    return str(data)

print(process_data(100))  # "100"
print(process_data("Hello"))  # "Hello"
