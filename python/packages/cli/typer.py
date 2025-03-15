'''
typer
- uses python type hints (int, str)
- best for building fast, user-friendly CLIs 
- built on click 

'pip install typer'
'''

import typer

app = typer.Typer()

@app.command()
def greet(name: str, age: int = 30):
    print(f"Hello, {name}! Age: {age}")

if __name__ == "__main__":
    app()
# python script.py greet Alice --age 25
# Output: Hello, Alice! Age: 25
