'''
[TWO SUM]
[ARRAY]
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

- hash map (dictionary) - unordered collection of unique values stored in key-value pair
d = {'a': 10, 'b': 20, 'c': 30}
d['a'] => 10
    - unordered: items in dict are stored without index value
    - unique: keys in dictionaries should be unique
    - mutable: can add/modify/remove key-value after the creation

Input: nums=[2,7,11,15] target=9
Output: [0,1]
Explanation: because nums[0] + nums[1] == 9
'''

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:            # type: ignore
        '''
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        '''
        hashMap = {} # val, indx

        for indx, val in enumerate(nums):
            diff = target - val

            if diff in hashMap:
                return [indx, hashMap[diff]]
            hashMap[val] = indx
