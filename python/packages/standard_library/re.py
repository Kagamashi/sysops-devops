'''
Regular Expressions

pattern matching
text manipulation
'''

from re import match, search, findall, sub 

pattern, string, replace = ""

match(pattern, string)        # match pattern from start of a string
search(pattern, string)       # search pattern in a string
findall(pattern, string)      # find all occurrences of pattern in a string
sub(pattern, replace, string) # replace pattern with replace in a string

text = "hello world"

print(match(r"hello", text))    # Match found
print(search(r"world", text))   # Search for "world"
print(findall(r"\w+", text))    # ['hello', 'world']
print(sub(r"world", "Python", text))  # "hello Python"
