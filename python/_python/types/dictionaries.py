'''
{"A": 1, "B": 2}
Dictionary is unordered collection of key-value pairs.
- key must be unique and immutable
- values can be of any data type

  keys():     Returns a view of all keys.
  values():   Returns a view of all values.
  items():    Returns a view of all key-value pairs.
  get(key):   Returns the value for the specified key (or None if the key doesn’t exist).
  update({key: value}):   Updates the dictionary with key-value pairs.
  len()
  fromkeys()  Returns dictionary with specified keys and value
'''

my_dict = {'name': 'Alice', 'age': 25}

# Accessing values
print(my_dict['name'])  # Alice

# Using methods
print(my_dict.keys())    # dict_keys(['name', 'age'])
print(my_dict.values())  # dict_values(['Alice', 25])
