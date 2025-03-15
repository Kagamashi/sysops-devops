''' 
restricts direct access to an objects attributes and methods.
(data hiding)

self.name - public attributes: accessible anywhere
_name - protected attributes: convention not enforced
__name - private attributes: cannot be accessed directly outside the class

- getter and setter methods can be used to access private variables
'''

class BankAccount:
    def __init__(self, balance):
        self.__balance = balance  # private variable

    def deposit(self, amount):
        self.__balance += amount

    def get_balance(self):
        return self.__balance

account = BankAccount(1000)
account.deposit(500)
print(account.get_balance())  # 1500
# print(account.__balance)  # Error! Private variable
