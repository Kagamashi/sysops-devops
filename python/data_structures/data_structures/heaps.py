'''
Specialized tree-based data stricture that satisfies heap property:
    - Min-Heap: parent node is always smaller than its children (smallest element at the root)
    - Max-Heap: parent node is always greater than its children (largest element at the root)

    - heapq module implement Min-Heap by default

use case:
    priority queues
    scheduling
    efficient sorting algorithms (eg Heap Sort)
'''

import heapq  # type: ignore

## Min-Heap
min_heap = []
heapq.heappush(min_heap, 10)
heapq.heappush(min_heap, 5)
heapq.heappush(min_heap, 15)
heapq.heappush(min_heap, 1)

print(min_heap)  # [1, 5, 15, 10] (Heap order is maintained)

# Extract the smallest element (root of the heap)
smallest = heapq.heappop(min_heap)
print(smallest) # 1


## heapify() converts a list into a Min-Heap
numbers = [10, 3, 5, 2, 8]
heapq.heapify(numbers)
print(numbers)  #  [2, 3, 5, 10, 8]


## Max-Heap
# heapq only supports Min-Heaps, but we can simulate a Max-Heap by storing negative values
max_heap = []
heapq.heappush(max_heap, -10)  # Insert negative values
heapq.heappush(max_heap, -5)
heapq.heappush(max_heap, -15)

print(-heapq.heappop(max_heap))  # 15 (Largest element first)


## implementing Custom Heap (Class-Based)
class MinHeap:
    def __init__(self):
        self.heap = []

    def push(self, val):
        heapq.heappush(self.heap, val)

    def pop(self):
        return heapq.heappop(self.heap)

    def peek(self):
        return self.heap[0] if self.heap else None

    def size(self):
        return len(self.heap)

# Example Usage
h = MinHeap()
h.push(10)
h.push(5)
h.push(1)
print(h.pop())  # 1 (Smallest element)
