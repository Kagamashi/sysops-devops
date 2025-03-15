'''
Python Debugger (pdb) is a built-in module for step-by-step debugging of Python code.
It allows breakpoints, inspect variables and control execution flow manually.
To start the debugger use : pdb.set_trace()

Common pdb commands:
  l: List the code around the current line.
  n: Go to the next line of code.
  s: Step into a function.
  c: Continue execution until the next breakpoint.
  p var: Print the value of a variable var.

While running the code, you'll enter interactive debugging at the line with pdb.set_trace().

Running in debugging mode from command line:
  python -m pdb my_script.py

'''

import pdb

def divide(a, b):
    pdb.set_trace()  # Start the debugger here
    return a / b

divide(10, 2)
