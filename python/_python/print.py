'''
print() outputs data to the console
Syntax: print(value, ..., sep=' ', end='\n')
  sep: Defines the separator between multiple values (default is space).
  end: Defines what to print at the end (default is a newline \n).
'''

# Printing multiple values
x = 10
y = 5
print("x is", x, "and y is", y)  # x is 10 and y is 5

print("apple", "banana", "cherry", sep=", ")  # apple, banana, cherry
print("Hello", end="!")  # Hello!


'''
input() is used to get user input from the console
[!] always returns a string
Syntax: input(prompt)
  prompt: A string that displays a message to the user.
'''

# Getting user input as a string
name = input("Enter your name: ")
print("Hello,", name)

# Getting user input as a float
price = float(input("Enter the price: "))
print("The price is", price)
