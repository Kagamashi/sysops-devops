# STRINGS
'''
strings are arrays of bytes representing unicode characters
Python does not have a character data type, a single character is simply a string with a length of 1

Escape characters:
  \'   Single Quote
  \\   Backslash
  \n   New Line
  \r   Carriage Return
  \t   Tab
  \b   Backspace
  \f   Form Feed
  \ooo Octal value
  \xhh Hex value

String methods:
  upper()
  lower()
  strip()       # removes whitespace from beginning or end
  lstrip()
  rstrip()
  replace("old", "new")
  split(",")    # split string into substrings
  len()
  startswith()  # bool: true/false
  endswith()
  join()

Slicing:
  a = "slicing"
  a[1]
  a[7:12]
  a[:5]
  a[::-1]   # reverse string

string methods: https://www.w3schools.com/python/python_strings_methods.asp
'''

# multiline strings
a = """Lorem ipsum dolor sit amet,
consectetur adipiscing elit..."""

# F-strings
name = "John"
age = 36
txt = f"My name is {name}, and I am {age}" # f-strings (older alternative was .format())
print(txt)
