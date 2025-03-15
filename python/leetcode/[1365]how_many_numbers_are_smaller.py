'''
[ARRAY]
Given an array nums for each nums[i] find out how many numbers in the array are smaller than it.
For each nums[i] count the number of valid j's such that j != i and nums[j] < nums[i]

Solution: Instead of iterating twice (O(n^2) time and O(N) space) -> sort the list in temp list, 
dict the value for each num (not identical) in temp list where index of first new number also represents previous numbers bigger than

Time O(nlogn) - sorting
Space O(n) - dict

TIME COMPLEXITY > SPACE (space is cheap)

Example:
    Input: nums = [8, 1, 2, 2, 3]
    Output: [4, 0, 1, 1, 3]
'''

class Solution:
    def smallerNumbersThanCurrent(self, nums: List[int]) -> List[int]:      # type: ignore
        temp = sorted(nums) # [1,2,2,3,8] sorting helps us determine how many numbers are smaller than given number
        
        d={}
        for i,num in enumerate(temp): # since temp is sorted, first occurence index of num directly gives the count of numbers smaller than num
            if num not in d: 
                d[num]=i

        ret = []

        for i in nums:
            ret.append(d[i])

        return ret
