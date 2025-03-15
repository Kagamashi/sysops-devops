''' 
Functions in Python are defined using def keyword

- functions can return values, if a function doesn't specify return it returns None by default
- functions accept arguments (parameters)
    default: Syntax: def function_name(param=default_value)
    positional: greet(Alice)
    keyword: greet(name = "Alice")
    arbitrary:
        *args if we don't know how many arguments will be passed
        **kwargs if we don't know how many keyword arguments will be passed
- enforce positional arguments by adding ", /" after arguments: def function(x, /)
- enforce keyword-only arguments by adding "*," before arguments: def function(*, x)

built-in functions: https://docs.python.org/3/library/functions.html
'''

def my_function(x):
  return 5 * x

# any argument before the / , are positional-only, and any argument after the *, are keyword-only.
def my_function(a, b, /, *, c, d):
    print(a + b + c + d)

my_function(5, 6, c = 7, d = 8)
