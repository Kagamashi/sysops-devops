'''
for loop is used to iterate over a sequence (list, tuple, string) or any other literable object
it allows to execute a block of code for each item in the sequence

- break statement stops the loop even if the condition is true
- continue statement stops current iteration
- pass is a placeholder, does nothing
- else statement runs when the condition is no longer true
'''

for char in "some_random_string":
    if char == 'P':
        continue
    if char == 'n':
        break
    if char > 'w':
        pass
    print(char)
else:
    print("Finished!")

# range() function returns a sequence of numbers, starting from 0 (by default) and increments by 1 (by default) and ends at specieid number
for x in range(2, 30, 3):
    print(x)