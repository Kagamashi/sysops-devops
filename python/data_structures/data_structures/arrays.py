'''
Store multiple values in a single variable

- uses array module (or numpy)
- can only store elements of the same data type
- lists can be ussed as array since they can store multiple data types hence are more flexible
- numpy allows multi-dimensional arrays

append(value)
insert(index, value)
remove(value): removes first occurence of value
pop(index): removes element at index
index(value): returns index at which value exists
reverse()
len()

use case:
  array.array() for small arrays, strict type enforcement
  python list for general-purpose collection
  numpy.array() for scientific computing, large datasets
'''

import array
# create an array of integers ('i' denotes typecode for integers)
arr = array.array('i', [1, 2, 3, 4, 5])
print(arr)  # array('i', [1, 2, 3, 4, 5])

first_element = arr[1]


import numpy as np
matrix = np.array([[1, 2, 3], [4, 5, 6]])  # 2D Array
print(matrix.shape)  # (2, 3) -> (2 rows, 3 columns)
