'''
[ARRAY]
Given an array nums of n integers, where nums[i] is in range [1,n], 
return an array of all integers in the range [1,n] that do not appear in nums

- Check given list for missing numbers range(1, len(nums))

Complexity:
    Time O(N) iterate through range and append tonew list if not in given list
    Space O(N)

Input: nums = [4,3,2,7,8,2,3,1]
Output: [5,6]
n = 8
'''

class Solution:
    def findDisappearedNumbers(self, nums: List[int]) -> List[int]:        # type: ignore
        setNums = set(nums) # remove duplicates

        ret = []

        for i in range(1, len(nums)+1): 
            if i not in setNums:
                ret.append(i)

        return ret 


        # abs() # return absolute value of a number
        # # Improves Space complexity to O(1) by modifying in-place
        # for i in range (len(nums)):
        #     temp = abs(nums[i]) - 1
        #     if nums[temp] > 0:
        #         nums[temp] *= -1

        # res = []
        # for i,n in enumerate(nums):
        #     if n > 0:
        #         res.append(i+1)
        
        # return res
