'''
Command-Line Arguments

CLI scripts
handling user inputs in cli tools
'''

import argparse

parser = argparse.ArgumentParser(description="A simple CLI tool")

parser.add_argument()       # defines command line argument
parser.add_argument_group() # add argument group
parser.parse_args()         # parse arguments provided by the user
parser.print_usage()        # print usage message
parser.set_defaults()       # set default values

parser.add_argument("name", help="Your name")
parser.add_argument("--age", type=int, help="Your age")

args = parser.parse_args()
print(f"Hello, {args.name}! Age: {args.age}")
# python script.py Alice --age 30
# Output: Hello, Alice! Age: 30
