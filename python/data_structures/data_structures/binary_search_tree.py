'''
Binary Search Tree (BST) is a tree data structure where:
- each node has at most two children: left and right
- left subtree contains nodes with values less than the parent node
- right subtree contains nodes with values greater than the parent node


use case:
  efficient for searching, inserting, deleting elements
  databases
  file systems
  auto-complete features
'''

## BST Node Class
class Node:
    def __init__(self, value):
        self.value = value
        self.left = None  # Left child
        self.right = None  # Right child


## BST Class
class BST:
    def __init__(self):
        self.root = None  # Root of the tree

    # Insert a new node
    def insert(self, value):
        self.root = self._insert(self.root, value)

    def _insert(self, root, value):
        if root is None:
            return Node(value)
        if value < root.value:
            root.left = self._insert(root.left, value)
        else:
            root.right = self._insert(root.right, value)
        return root

    # Search for a node
    def search(self, value):
        return self._search(self.root, value)

    def _search(self, root, value):
        if root is None or root.value == value:
            return root is not None  # Return True if found
        if value < root.value:
            return self._search(root.left, value)
        return self._search(root.right, value)

    # Inorder Traversal (Left -> Root -> Right)
    def inorder(self):
        result = []
        self._inorder(self.root, result)
        return result

    def _inorder(self, root, result):
        if root:
            self._inorder(root.left, result)
            result.append(root.value)
            self._inorder(root.right, result)

    # Delete a node
    def delete(self, value):
        self.root = self._delete(self.root, value)

    def _delete(self, root, value):
        if root is None:
            return root
        if value < root.value:
            root.left = self._delete(root.left, value)
        elif value > root.value:
            root.right = self._delete(root.right, value)
        else:
            # Case 1: Node has no child
            if root.left is None:
                return root.right
            elif root.right is None:
                return root.left
            # Case 2: Node has two children
            min_larger_node = self._find_min(root.right)
            root.value = min_larger_node.value
            root.right = self._delete(root.right, min_larger_node.value)
        return root

    def _find_min(self, root):
        while root.left:
            root = root.left
        return root

# Example usage
tree = BST()
tree.insert(50)
tree.insert(30)
tree.insert(70)
tree.insert(20)
tree.insert(40)

print(tree.search(30))  # True
print(tree.search(100)) # False
print(tree.inorder())   # [20, 30, 40, 50, 70]

tree.delete(30)
print(tree.inorder())  # [20, 40, 50, 70]


## Inorder Traversal (Left → Root → Right) 
# outputs elements in sorted order
tree.inorder()  # [20, 30, 40, 50, 70]


## Preorder Traversal (Root → Left → Right)
# useful for copying the tree structure
def preorder(root):
    if root:
        print(root.value, end=" ")
        preorder(root.left)
        preorder(root.right)


## Postorder Traversal (Left → Right → Root)
# used in tree deletion problems
def postorder(root):
    if root:
        postorder(root.left)
        postorder(root.right)
        print(root.value, end=" ")
