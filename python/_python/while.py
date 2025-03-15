'''
whie loop repeats as long as the specified condition is True

- break statement stops the loop even if the condition is true
- continue statement stops current iteration
- else statement runs when the condition is no longer true
'''

i = 1
while i < 6:
  print(i)
  if i == 3:
    break
  if i == 5:
    continue
  i += 1
else:
  print("i is no longer less than 6")
