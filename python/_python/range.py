'''
range() function is used to generate a sequence of numbers
commonly used in loops and other iterable operations

- range() returns a lazy sequence (doesn't store values in memory, generates them when needed).

range(start, stop, step)
    start (optional) – The number to start from (default = 0).
    stop (required) – The number to stop before.
    step (optional) – The increment between numbers (default = 1).

'''

# range(stop): Generates numbers from 0 to stop - 1
for i in range(5):
    print(i)
# 0
# 1
# 2
# 3
# 4


# range(start, stop, step): Defines a step between numbers
for i in range(1, 10, 2):
    print(i)
# 1
# 3
# 5
# 7
# 9


# ✅ Step can be negative for reverse sequences:
for i in range(10, 0, -2):
    print(i)
# 10
# 8
# 6
# 4
# 2
