'''
Prefix Sum (also called Cumulative Sum) is an algorithmic technique used to quickly compute sums of subarrays in an efficient manner

+ reduces repeated summation operations in O(1) time after preprocessing
+ used in range sum queries, dynamic programming, and optimization problems
+ common in problems invoking subarrays && intervals

[idea]
Given an array arr, its prefix sum array prefix_sum is defined as:
prefix_sum[i] = arr[0] + arr[1] + ... + arr[i]

It allows fast range sum queries instead of recalculating sums each time:
sum(i, j) = prefix_sum[j] - prefix_sum[i - 1]
'''

def prefix_sum(arr):
    n = len(arr)
    prefix = [0] * n # creates list of size n filled with 0
    prefix[0] = arr[0]
    
    for i in range(1, n):
        prefix[i] = prefix[i - 1] + arr[i]  # each prefix[i] stores the sum of elements from index 0 to i
    
    return prefix

arr = [3, 1, 4, 1, 5, 9, 2]
print(prefix_sum(arr))  # Output: [3, 4, 8, 9, 14, 23, 25]


'''
Fast Range Sum Queries
problem: find the sum of elements from index L to R (arr[L]+...+arr[R])
instead of looping through the array O(n), use prefix sums O(1)
'''
def range_sum(prefix, L, R):
    if L == 0:
        return prefix[R]
    return prefix[R] - prefix[L - 1] # (14-3), (25-4)

arr = [3, 1, 4, 1, 5, 9, 2]
prefix = prefix_sum(arr) # Output: [3, 4, 8, 9, 14, 23, 25]

print(range_sum(prefix, 1, 4))  # Output: 11 (1 + 4 + 1 + 5)
print(range_sum(prefix, 2, 6))  # Output: 21 (4 + 1 + 5 + 9 + 2)



'''
2D Prefix Sum (for Matrices)
stores the sum of elements from the top-left (0,0) to (i,j)

for each cell (i,j):
    prefix[i][j] = matrix[i][j] + prefix[i−1][j] + prefix[i][j−1] − prefix[i−1][j−1]

where:
    prefix[i-1][j] → Sum of elements above (i, j)
    prefix[i][j-1] → Sum of elements to the left of (i, j)
    prefix[i-1][j-1] → Common overlapping sum (subtracted once to avoid double-counting)
'''
def compute_2d_prefix(matrix):
    rows, cols = len(matrix), len(matrix[0])
    prefix = [[0] * cols for _ in range(rows)] # initializes 2D list (matrix) filled with zeros
    
    for i in range(rows):
        for j in range(cols):
            prefix[i][j] = matrix[i][j]
            
            if i > 0:
                prefix[i][j] += prefix[i - 1][j] # sum of elements above (i,j)
            if j > 0:
                prefix[i][j] += prefix[i][j - 1] # sum of elements to the left of (i,j)
            if i > 0 and j > 0:
                prefix[i][j] -= prefix[i - 1][j - 1] # common overlapping sum (substracted once to avoid double-counting)

    return prefix

matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
prefix_matrix = compute_2d_prefix(matrix)
print(prefix_matrix)
# 1   3   6
# 5  12  21
# 12  27  45
