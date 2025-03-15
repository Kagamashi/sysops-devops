'''
Ordered collection of objects

- differs from lists in the way that they store elements in memory
    (lists use a contiguous memory block to store references to their data)
- each elements of a linked list is called a node, and every node has two fields:
    data: contains value to be stored in the data
    next: contains a reference to the next node on the list
- first node is called head, and last node must have it's next reference pointing to None

use case:
    queues (FIFO) or stacks (LIFO)
    graphs: for example adjacency list to show relationship between objects in directed acyclic graph (DAG)
'''


''' SINGLY LINKED LIST'''
# Node class represents an individual node in the linked list
class Node:
    def __init__(self, data):
        self.data = data  # Store data
        self.next = None  # Pointer to the next node (initially None)

# Linked List class to manage the linked list operations
class LinkedList:
    def __init__(self):
        self.head = None  # Head of the linked list (initially None)

    # Insert a new node at the end
    def append(self, data):
        new_node = Node(data)
        if not self.head:  # If list is empty, set new node as head
            self.head = new_node
            return
        last = self.head
        while last.next:      # Traverse to the last node
            last = last.next
        last.next = new_node  # Set last node's next to new node

    # Insert a node at the beginning
    def prepend(self, data):
        new_node = Node(data)
        new_node.next = self.head  # Set new node's next to current head
        self.head = new_node       # Update head to new node

    # Delete a node by value
    def delete(self, key):
        temp = self.head

        # If head node holds the key, update head
        if temp and temp.data == key:
            self.head = temp.next
            temp = None
            return

        prev = None
        while temp and temp.data != key:  # Search for the key
            prev = temp
            temp = temp.next

        if temp is None:  # If key is not found
            return

        prev.next = temp.next  # Unlink the node from the list
        temp = None  # Delete node

    # Print the linked list
    def print_list(self):
        temp = self.head
        while temp:
            print(temp.data, end=" -> ")
            temp = temp.next
        print("None")  # End of the list

# Example usage
llist = LinkedList()
llist.append(10)
llist.append(20)
llist.prepend(5)
llist.print_list()  # 5 -> 10 -> 20 -> None

llist.delete(10)
llist.print_list()  # 5 -> 20 -> None


''' DOUBLY LINKED LIST allows traversal in both directions
by maintaining pointer to previoud node as well '''
class DNode:
    def __init__(self, data):
        self.data = data
        self.next = None  # Pointer to next node
        self.prev = None  # Pointer to previous node

class DoublyLinkedList:
    def __init__(self):
        self.head = None  # Head of the list

    # Append node at the end
    def append(self, data):
        new_node = DNode(data)
        if not self.head:
            self.head = new_node
            return
        last = self.head
        while last.next:
            last = last.next
        last.next = new_node
        new_node.prev = last  # Set previous pointer

    # Print forward traversal
    def print_forward(self):
        temp = self.head
        while temp:
            print(temp.data, end=" <-> ")
            temp = temp.next
        print("None")

# Example usage
dlist = DoublyLinkedList()
dlist.append(10)
dlist.append(20)
dlist.append(30)
dlist.print_forward()  # 10 <-> 20 <-> 30 <-> None
