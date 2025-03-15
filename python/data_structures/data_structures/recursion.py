'''
RECURSION is a technique where a function calls itself to solve smaller subproblems of a larger problem
- used in problems that can be broken into smaller instances of the same problem (eg factorial, fibonacci, tree traversals)
- base case stops recursion to prevent infinite loops
- recursive case reduces the problem to a simpler version of itself

def recursive_function(parameters):
    if base_case_condition:
        return base_case_value
    else:
        return recursive_function(modified_parameters)

use case:
  tree traversals (e.g. Binary Trees, Graphs, File Systems)
  divide-and-conquer algorithms (Merge Sort, Quick Sort, DFS)
  backtracking problems (Maze solving, N-Queens)
'''

## Factorial
def factorial(n):
    if n == 0:  # Base case
        return 1
    return n * factorial(n - 1)  # Recursive case

print(factorial(5))  # 120


## Fibonacci
# base cases: fib(0) == 0, fib(1) == 1
# recursive case: fib(n) = fib(n-1) + fib(n-2)
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print(fibonacci(6))  # 8

# more efficient approach using memorization (caching results)
from functools import lru_cache  # type: ignore

@lru_cache(None)
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print(fibonacci(50))  # 12586269025 (Fast!)


## Sum of Digits
def sum_of_digits(n):
    if n == 0:
        return 0
    return (n % 10) + sum_of_digits(n // 10)

print(sum_of_digits(123))  # 6


## Reverse a String
def reverse_string(s):
    if len(s) == 0:
        return s
    return s[-1] + reverse_string(s[:-1])

print(reverse_string("hello"))  # "olleh"
