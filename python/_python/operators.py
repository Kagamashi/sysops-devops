# ARITHMEIC OPERATORS
'''
+   Addition
-   Subtraction
*   Multiplication
/   Division (returns a float)
//  Floor Division (returns the quotient rounded down to the nearest integer)
%   Modulus (returns the remainder)
**  Exponentiation (raises the first number to the power of the second)
'''


# COMPARISON OPERATORS
'''
==  Equal to
!=  Not equal to
<   Less than
>   Greater than
<=  Less than or equal to
>=  Greater than or equal to
'''


# ASSIGNMENT OPERATORS
'''
=   Assigns a value to a variable.
+=  Adds the right operand to the left operand and assigns the result.
-=  Subtracts the right operand from the left operand and assigns the result.
*=  Multiplies the left operand by the right operand and assigns the result.
/=  Divides the left operand by the right operand and assigns the result.
//= Floor divides the left operand by the right operand and assigns the result.
%=  Takes modulus using two operands and assigns the result.
**= Raises the left operand to the power of the right operand and assigns the result.
'''


# LOGICAL OPERATORS
'''
and   Returns True if both operands are true.
or    Returns True if at least one operand is true.
not   Returns True if the operand is false (reverses the result).
'''


# MEMBERSHIP OPERATORS
'''
in     Returns True if a value exists in the sequence.
not in Returns True if a value does not exist in the sequence.
'''
my_list = [1, 2, 3, 4, 5]
my_string = "hello"

print(3 in my_list)      # True (3 is in the list)
print(6 not in my_list)  # True (6 is not in the list)
print('h' in my_string)  # True ('h' is in the string)


# IDENTITY OPERATORS
'''
is     Returns True if both variables are the same object.
is not Returns True if both variables are not the same object.
'''
a = [1, 2, 3]
b = a
c = [1, 2, 3]

print(a is b)      # True (a and b point to the same list object)
print(a is not c)  # True (a and c point to different objects, even though they contain the same values)


# BIWISE OPERATORS
'''
&  AND    Sets each bit to 1 if both bits are 1.
|  OR     Sets each bit to 1 if one of the bits is 1. 
^  XOR    Sets each bit to 1 if only one of the bits is 1.
~  NOT    Inverts all the bits.
<< Zero fill left shift   Shift left by pushing zeros in from the right and let the
>> Signed right shift     Shift right by pushing copies of the leftmost bit in from the left, and let the rightmost bits fall
'''
