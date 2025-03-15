'''
Two Pointer Technique is an efficient algorithmic approach used for solving array and string problems by using two indices (pointers) that traverse the structure in specific way

+ used for searching, sorting, and optimization problems
+ reduces time complexity from O(n²) to O(n) or O(log n)
+ common in problems involving sorted arrays, subarrays, linked lists

types of Two Pointer approach:
    opposite direction (left-right) : one pointer starts from the left, the other from the right
        finding pairs, palindromes, sorting
    same direction (sliding window) : both pointers move in the same direction
        subarrays, searching, string problems
    fast-slow (tortoise & hare) : one pointer moves faster than the other
        linked list cycle detection
'''

''' Opposite Direction [left-right]
    - Used for finding pairs with a given sum in a sorted array.
    ✅ More efficient (O(n)) than brute-force (O(n²)) since each element is checked at most once '''
def two_sum_sorted(arr, target):
    left, right = 0, len(arr) - 1  # Two pointers

    while left < right:
        current_sum = arr[left] + arr[right]
        
        if current_sum == target:
            return [left, right]  # Found the pair
        
        if current_sum < target:
            left += 1  # Move left pointer to increase sum
        else:
            right -= 1  # Move right pointer to decrease sum

    return []  # No pair found

arr = [1, 2, 3, 4, 6, 8, 9]
target = 10
print(two_sum_sorted(arr, target))  # [0, 6]


''' Same Direction [sliding window]
    - Used when processing contiguous subarrays or substrings
    ✅ Time Complexity: O(n), since each character is processed at most twice.
'''
def longest_unique_substring(s):
    seen = set()  # track characters in current window
    left = 0      # left boundary of the window
    max_length = 0      # stores maximum length found
    
    for right in range(len(s)):  # Right pointer expands the window
        while s[right] in seen:  # If duplicate found shrink from the left
            seen.remove(s[left]) # Remove leftmost character
            left += 1   # Move left pointer forward
        
        seen.add(s[right]) # Add new unique character to the set
        max_length = max(max_length, right - left + 1)  # Update max length
    
    return max_length

s = "abcabcbb"
print(longest_unique_substring(s))  # 3


''' Fast-Slow Pointers [tortoise && hare]
    - Used for cycle detection in linked lists (O(n)).
    - Also known as Floyd’s Tortoise and Hare Algorithm.
    ✅ Time Complexity: O(n), as each node is visited at most once. '''
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next # Pointer to the next node

def has_cycle(head):
    slow, fast = head, head  # Slow moves one step at a time, fast moves two steps

    while fast and fast.next: # Ensures fast does not reach None
        slow = slow.next      # Move slow pointer one step
        fast = fast.next.next # Fast pointer moves twice as fast

        if slow == fast:
            return True  # Cycle detected
    
    return False  # No cycle

# Example usage:
node1 = ListNode(1)
node2 = ListNode(2)
node3 = ListNode(3)
node1.next = node2
node2.next = node3
node3.next = node1  # Cycle

print(has_cycle(node1))   True

'''
Cycle : traversal never reaches None causing an infinite loop
1 → 2 → 3 → 4
         ↑    ↓
         6 ← 5
'''