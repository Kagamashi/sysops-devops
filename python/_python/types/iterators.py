''' 
Iterator in Python is an object that allows to traverse through all elements of a collection (list, tuples) one by one.
  iter(): Returns the iterator object.
  next(): Returns the next element in the sequence.
'''

my_list = [1, 2, 3, 4]
my_iter = iter(my_list)  # Create an iterator

print(next(my_iter))  # Output: 1
print(next(my_iter))  # Output: 2
print(next(my_iter))  # Output: 3
