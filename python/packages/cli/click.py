'''
click
- easier syntax than argparse
- supports nested commands and default values
- best for complex CLIs with multiple commands

'pip install click'
'''

import click

@click.command()
@click.option("--name", prompt="Your name", help="Enter your name")
def greet(name):
    click.echo(f"Hello, {name}!")

if __name__ == "__main__":
    greet()
# python script.py
# Prompt: Your name: Alice
# Output: Hello, Alice!
