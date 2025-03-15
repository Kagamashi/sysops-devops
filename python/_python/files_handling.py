''' 
open() functions is used to open a file
must specify the file name and mode in which the file should be opened:
    'r': Read (default) – Opens a file for reading. If the file does not exist, it raises an error.
    'w': Write – Opens a file for writing. If the file does not exist, it creates a new one. If the file exists, it truncates (overwrites) the content.
    'a': Append – Opens a file for appending. If the file does not exist, it creates a new one. If the file exists, new data is added to the end.
    'r+': Read and Write – Opens a file for both reading and writing. The file must exist. '''
# Opening a file in read mode
file = open("example.txt", "r")


''' 
with statement is the recommended way to work with files
it ensures that the file is properly closed after its suite finishes

with statement simplifies the code and makes it more readable by eliminating the need for explicitly closing the file using file.close()  '''
# Using 'with' statement to read a file
with open("example.txt", "r") as file:
    content = file.read()
    print(content)

# Using 'with' statement to write to a file
with open("example.txt", "w") as file:
    file.write("This is written using the 'with' statement.\n")


''' 
once file is opened we can read its contents using one of the following methods:
    read(): Reads the entire content of the file as a single string.
    readline(): Reads one line at a time from the file.
    readlines(): Reads all lines of the file and returns them as a list of strings. '''
# read()
file = open("example.txt", "r")
content = file.read()
print(content)
file.close()

# readline()
file = open("example.txt", "r")
line = file.readline()  # Reads the first line
print(line)
file.close()

# readlines()
file = open("example.txt", "r")
lines = file.readlines()  # Returns a list of all lines
print(lines)
file.close()


''' To write data to a file:
    write(): Writes a single string to the file. You need to manually add newline characters (\n) if you want to separate lines.
    writelines(): Writes a list of strings to the file. Each string in the list is written as a line, but newline characters must be included in the strings. '''
# write()
file = open("example.txt", "w")
file.write("This is a new line.\n")  # Remember to add '\n' for a new line
file.close()

# writelines()
file = open("example.txt", "w")
lines = ["First line\n", "Second line\n", "Third line\n"]
file.writelines(lines)
file.close()
