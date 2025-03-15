'''
Linear structure that follows FIFO principle, meaning elements are added at the rear and removed from the front

- collections.deque package which is optimized for fast append and pop operations from both ends
- queue.Queue (thread-safe)
- Python list can albo be used as a queue, but it's not efficient (removing from the front is slow)

use case:
  task scheduling (job queues, process scheduling)
  breadth-first search (BFS) in graphs and trees
  handling requests in web servers
  multi-threaded applications (using queue.Queue)
  priority queues (heapq)
'''

## collections.deque
from collections import deque  # type: ignore

queue = deque() # initialize a queue

queue.append("A") # enqueue (add elements to the rear)
queue.append("B")
queue.append("C")

# dequeue (remove elements from the front)
print(queue.popleft())  # A
print(queue.popleft())  # B

# check if queue is empty
print(len(queue) == 0)  # False


## queue.Queue
import queue  # type: ignore

q = queue.Queue()

q.put("Task1") # enqueue
q.put("Task2")

# dequeue
print(q.get())  # Task1
print(q.get())  # Task2

# check if queue is empty
print(q.empty())  # True



## implementing Custom Queue Class
class Queue:
    def __init__(self):
        self.items = []

    def enqueue(self, item):
        self.items.append(item)  # add to rear

    def dequeue(self):
        if not self.is_empty():
            return self.items.pop(0)  # remove from front

    def is_empty(self):
        return len(self.items) == 0

    def peek(self):
        return self.items[0] if not self.is_empty() else None

    def size(self):
        return len(self.items)

# example usage
q = Queue()
q.enqueue(1)
q.enqueue(2)
print(q.dequeue())  # 1


## priority queue (Heap-Based) : ensures elements with higher priority are dequeued first
import heapq  # type: ignore

pq = []
heapq.heappush(pq, (1, "Low priority task"))
heapq.heappush(pq, (0, "High priority task"))

print(heapq.heappop(pq))  # (0, 'High priority task') (Lowest number has highest priority)

