'''
Regular expressions (regex) are used for pattern matching in strings.
re module in Python provides functions to work with regex patterns;
  re.match(): Checks for a match at the beginning of the string.
  re.search(): Searches the entire string for a match.
  re.findall(): Returns all matches as a list.
  re.sub(): Replaces all matches with a new string.

Special characters in Regex:
  ^: Matches the start of a string.
  $: Matches the end of a string.
  .: Matches any character except a newline.
  *: Matches 0 or more repetitions of the preceding character.
  +: Matches 1 or more repetitions of the preceding character.
  []: Matches any one of the characters in the set.
  \d: Matches any digit (equivalent to [0-9]).
  \w: Matches any word character (alphanumeric or underscore).
'''

import re

# re.match() example
pattern = r"\d+"  # Matches one or more digits
result = re.match(pattern, "123abc")
print(result.group())  # 123

# re.search() example
result = re.search(pattern, "abc123")
print(result.group())  # 123

# re.findall() example
result = re.findall(pattern, "abc123xyz456")
print(result)  # ['123', '456']

# re.sub() example (replace digits with 'X')
result = re.sub(pattern, "X", "abc123xyz456")
print(result)  # abcXxyzX

# Find all words in a string
pattern = r"\w+"
text = "Hello, World! Python is awesome."
result = re.findall(pattern, text)
print(result)  # ['Hello', 'World', 'Python', 'is', 'awesome']
