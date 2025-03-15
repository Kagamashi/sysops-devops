'''
[A, B, C]
List is an ordered, mutable collection of items.
- allows duplicates
- can contain elements of different data types.
- negative indexing means start from the end

  append(item)    Adds an item to the end.
  clear()         Empties the list
  copy()
  pop()           Removes specified index (or last item if index no specified)
  extend([items]) Adds all items from another list.
  remove(item)    Removes the first occurrence of the specified item.
  sort()          Sorts the list in place.
  reverse()       Reverses the list in place.
  len()
  insert()       
  count()         Returns number of elements with specified value 
'''

my_list = [1, 2, 3]
my_list.append(4) # [1, 2, 3, 4]

my_list.pop() # [1, 2, 3]

my_list.extend([5, 6]) # [1, 2, 3, 5, 6]

thislist = list(("apple", "banana", "cherry")) # double brackets

# iterate over a list
thislist = ["apple", "banana", "cherry"]
for i in range(len(thislist)):
  print(thislist[i])

# sort descending
thislist.sort(reverse = True)

# customize sort function
def myfunc(n):
  return abs(n - 50)

thislist = [100, 50, 65, 82, 23]
thislist.sort(key = myfunc)
print(thislist)
