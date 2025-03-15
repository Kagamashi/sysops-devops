'''
Last-In-First-Out (LIFO) data structure meaning the last element added is the first one to be removed

- implementing using list (avoid popping from the beginning (pop(0)) as it has big complexity due to shifting elements)
- implementing a stack using collections.deque (recommneded)
- 

use case:
  undo/redo functionality (text editors, photoshop)
  backtracking algorithms (maze solving, DFS in graphs)
  function calls (recursion uses a call stack)
  expression evaluation (checking balanced parentheses)
'''

## Python list
stack = []

stack.append(1) # push elements to the stack
stack.append(2)
stack.append(3)

# pop elements from the stack
print(stack.pop())  # 3 (Last-in, first-out)
print(stack.pop())  # 2

# peek at the top element
print(stack[-1])  # 1

# check if the stack is empty
print(len(stack) == 0)  # False


## collections.deque (more efficient)
from collections import deque  # type: ignore

stack = deque()

stack.append(1) # push elements
stack.append(2)

# pop elements
print(stack.pop())  # 2


## Custom Stack Class
class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)  # Add to top

    def pop(self):
        if not self.is_empty():
            return self.items.pop()  # Remove top item

    def peek(self):
        return self.items[-1] if not self.is_empty() else None

    def is_empty(self):
        return len(self.items) == 0

    def size(self):
        return len(self.items)

# example usage
s = Stack()
s.push(5)
s.push(10)
print(s.pop())  # 10
