'''
{A, B, C}
Set is unordered, collection of unique items.
- do not allow duplicates
- useful for operations like union, intersection and difference
- can contain different data types

  add(item)
  remove(item)
  union():        Returns a new set with all items from both sets.
  intersection(): Returns a set with only the items present in both sets [&]
  difference():   Returns a set with items present in the first set but not in the second
  symmetric_difference():   Keeps all items EXCEPT the duplicates
'''

my_set = {1, 2, 3}
my_set.add(4)  # {1, 2, 3, 4}

# Set operations
set_a = {1, 2, 3}
set_b = {3, 4, 5}
print(set_a.union(set_b))         # {1, 2, 3, 4, 5}
print(set_a.intersection(set_b))  # {3}
