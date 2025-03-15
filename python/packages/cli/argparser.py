'''
argparse
- built into Python
- used for parsing command-line arguments
- best for simple CLIs
'''

import argparse

parser = argparse.ArgumentParser(description="A simple CLI tool")
parser.add_argument("name", help="Your name")
parser.add_argument("--age", type=int, help="Your age")

args = parser.parse_args()
print(f"Hello, {args.name}! Age: {args.age}")
# python script.py Alice --age 30
# Output: Hello, Alice! Age: 30
