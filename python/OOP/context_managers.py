''' Context Manager is used to manage resources efficiently.
Example: when working with files or network connections, a context manager ensures that resources are properly acquired and released, even if exceptions occur.
The most common way to use context managers is with WITH statement.
'''
# Using 'with' for file handling (no need to manually close the file)
with open("example.txt", "w") as file:
    file.write("Hello, World!")



''' Custom Context Managers
can be created by defining __enter__() and __exit__() nethods in a class '''
class MyContextManager:
    def __enter__(self):
        print("Entering the context")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Exiting the context")

with MyContextManager():
    print("Inside the context")

# Output:
# Entering the context
# Inside the context
# Exiting the context
