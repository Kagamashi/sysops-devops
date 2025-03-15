## pathlib (file and directory handling)
# provides an object-oriented approach to file paths
from pathlib import Path

file_path = Path("example.txt")

if file_path.exists():
    print("File exists!")
else:
    file_path.write_text("Hello, World!")  # Create and write text

