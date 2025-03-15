'''
[ARRAY]
Given an integer array nums, return true if any value appears at least twice in the array, 
and return false if every element is distinct.

Solution: O(N) iterate through list and create set
- sets are fast, empty Set cannot be created through {} (it creates dictionary), unless values are included
- set is implemented as hash table, so lookup/insert/delete should be in O(1) average
'''

List = [1, 2, 3, 1]
    
class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:      # type: ignore
        if len(set(nums)) == len(nums):
            return False
        else: 
            return True

empty_set = set()
empty_dict = {}
