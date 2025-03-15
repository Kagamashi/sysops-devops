'''
In-Memory File Handling

ByesIO : handling binary data without disk I/O
StringIO : handling string data without disk I/O
'''

from io import BytesIO

data = ""

BytesIO.write(data)  # write data to memory 
BytesIO.read()       # read data from memory
BytesIO.getvalue()   # get data from memory
BytesIO.seek()       # move cursor to specific position

buffer = BytesIO()
buffer.write(b"Hello, world!")  # Writing bytes
buffer.seek(0)  # Move to start
print(buffer.read())  # Output: b'Hello, world!'
