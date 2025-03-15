'''
- requires proper indentation
- supports logical conditions:
    equals: a == b
    not equals: a != b
    less than: a < b
    less than or equal to: a <= b
    greather than: a > b
    greaten than or equal to: a >= b
- if / elif / else
- and / or / not
- pass statement to avoid getting error
'''

x = 10
c = 5

if x > 15:
    print("x gt 15")
elif x > 5:
    print("x gt 5 and lt 15")
elif x == 10:
    print("x eq 10")
elif x > 5 and c > 2:
    print("sth")
elif x > 5 or c < 10:
    print("sth")
elif x > a:
    pass
else:
    print("x is 5 or less")
