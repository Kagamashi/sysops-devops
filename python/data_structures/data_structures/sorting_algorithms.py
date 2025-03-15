'''
Sorting is the process of arranging data in ascending/descending order

- python provides built-in sorting methods: sorted(), .sort()
- common sorting algorithms
    bubble sort
    selection sort
    insertion sort: small or nearly sorted lists
    merge sort: unsorted large datasets
    quick sort: fastest in most cases
    heap sort: fixed-size priority queues
    timsort (used in Python): general purpose sorting
'''

## sorted() returns new list
numbers = [5, 2, 9, 1]
sorted_numbers = sorted(numbers)  # Ascending order
print(sorted_numbers)  # [1, 2, 5, 9]


## .sort() sorts in place
numbers.sort()  # Modifies the original list
print(numbers)  # [1, 2, 5, 9]


## Bubble Sort (simple but inefficient)
# repeatedly swaps adjacent elements if they are in the wrong order
def bubble_sort(arr):
    n = len(arr)
    for i in range(n - 1):
        for j in range(n - 1 - i):
            if arr[j] > arr[j + 1]:  # Swap if elements are out of order
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr

print(bubble_sort([5, 1, 4, 2, 8]))  # [1, 2, 4, 5, 8]


## Selection Sort
# finds the minimum element and swaps it with the first unsorted element
def selection_sort(arr):
    n = len(arr)
    for i in range(n):
        min_idx = i
        for j in range(i + 1, n):
            if arr[j] < arr[min_idx]:  
                min_idx = j
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
    return arr

print(selection_sort([64, 25, 12, 22, 11]))  # [11, 12, 22, 25, 64]


## Insertion Sort
# efficient for nearly sorted data : O(n) best case
# works like sorting a hand of playing cards
def insertion_sort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key
    return arr

print(insertion_sort([9, 5, 1, 4, 3]))  # [1, 3, 4, 5, 9]


## Merge Sort : Divide & Conquer (efficient)
# good for sorting large datasets but requires extra space (not in-place)
def merge_sort(arr):
    if len(arr) > 1:
        mid = len(arr) // 2
        left = merge_sort(arr[:mid])
        right = merge_sort(arr[mid:])

        merged = []
        i = j = 0
        while i < len(left) and j < len(right):
            if left[i] < right[j]:
                merged.append(left[i])
                i += 1
            else:
                merged.append(right[j])
                j += 1
        merged.extend(left[i:])
        merged.extend(right[j:])
        return merged
    return arr

print(merge_sort([38, 27, 43, 3, 9, 82, 10]))  # [3, 9, 10, 27, 38, 43, 82]


## Quick Sort : Divide & Conquer (fast in most cases O(n log n), but worst case O(n^2) if the pivot is bad)
# uses a pivot element to partition the array
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)

print(quick_sort([10, 7, 8, 9, 1, 5]))  # [1, 5, 7, 8, 9, 10]


## Heap Sort (0(n log n) always)
# used in priority queues and scheduling
import heapq  # type: ignore

def heap_sort(arr):
    heapq.heapify(arr)  # Convert list into a heap
    return [heapq.heappop(arr) for _ in range(len(arr))]

print(heap_sort([4, 10, 3, 5, 1]))  # [1, 3, 4, 5, 10]


## Timsort used in Python's sorted() and .sort() (stable and in-place)
# hybrid of merge sort and insertion sort
