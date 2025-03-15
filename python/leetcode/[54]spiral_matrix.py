'''
[SPIRAL MATRIX]

Given an m x n matrix, return all elements of the matrix in spiral order.

Solution:
1) res.append elements of first non-empty list
2) res.append last element of all lists in order
3) res.append reverse of last list
4) res.append first element of remaining lists in reverse order

Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,3,6,9,8,7,4,5]
'''

class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:    # type: ignore
        ret = []

        # iterate as long as matrix is not empty
        while matrix:
            #1) add first row/list of matrix
            ret+=(matrix.pop(0))

            #2) append last element of all lists in order
            if matrix and matrix[0]:
                for row in matrix:
                    ret.append(row.pop())
            
            #3) add reverse of last row/list:
            if matrix:
                ret+=(matrix.pop()[::-1])

            #4) append first element of all rows/lists in reverse
            if matrix and matrix[0]:
                for row in matrix[::-1]:
                    ret.append(row.pop(0))

        return ret


## first solution:
# class Solution:
#     def spiralOrder(self, matrix: List[List[int]]) -> List[int]:    # type: ignore
#         res = []

#         while True:
#             res = []

#             def fin_check(): # check if loop can be finalized (matrix becomes empty)
#                 if len(matrix)==0:
#                     return True

#             # repeat until the matrix is empty
#             while True:
#                 res.extend(matrix[0]) # add elements of the first row
#                 matrix.pop(0)  # remove first row
#                 matrix = [item for item in matrix if len(item)>0]

#                 if fin_check(): return res

#                 for col in matrix:
#                     res.append(col[-1]) # append last element of each column
#                     col.pop(-1) # remove last element of each column
#                 matrix = [item for item in matrix if len(item)>0]

#                 if fin_check(): return res

#                 res.extend(matrix[-1][::-1]) # extract last row in reverse order
#                 matrix.pop(-1) 
#                 matrix = [item for item in matrix if len(item)>0]

#                 if fin_check(): return res

#                 for col in reversed(matrix):
#                     res.append(col[0]) 
#                     col.pop(0)
#                 matrix = [item for item in matrix if len(item)>0]

#                 if fin_check(): return res
