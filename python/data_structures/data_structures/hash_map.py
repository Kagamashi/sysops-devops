'''
Hash Table (also known as Hash Map) stores key-value pairs.

- uses hash function to compute an index where the value is stored allowing for fast lookups, insertions and deletion
- built-in dictionary is implemented as hash table
- hash tables may produce collisions (when to keys hash to the same index)
  Python handle this using open addressing with probing or chaining (linked lists)
  built-in dict avoids collision efficiently

use case: 
  fast lookups, insertions, 
  key-value pairs (caching, databases, indexing), 
  efficient for large datasets with frequent access operations
'''

# Creating a dictionary (hash table)
hash_table = {
    "name": "Alice",
    "age": 30,
    "city": "New York"
}

# Accessing a value using a key
print(hash_table["name"]) 

# Adding a new key-value pair
hash_table["job"] = "Engineer"

# Updating a value
hash_table["age"] = 31

# Deleting a key-value pair
del hash_table["city"]

# Checking if a key exists
print("age" in hash_table)  # True

# Iterating through a dictionary
for key, value in hash_table.items():
    print(f"{key}: {value}")
