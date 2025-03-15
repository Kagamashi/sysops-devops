'''
[ARRAY]
Given an array nums containing n distinct numbers in range [0, n],
return the only number in the range that is missing from the array

- it's [0, n]
nums = [0,1] we have 2 numbers so n=2 hence all numbers are in range [0,2]

len = O(1)
sum = O(N)
range object creation = O(1)
+1 in range(n) because n will be excluded otherwise
'''

class Solution:
    def missingNumber(self, nums: List[int]) -> int:    # type: ignore
        return sum(range(len(nums)+1))-sum(nums)

        # nums.sort()
        # for i,v in enumerate(nums):
        #     if (i != v):
        #         return v-1
        #     if v == len(nums):
        #         return v+1
