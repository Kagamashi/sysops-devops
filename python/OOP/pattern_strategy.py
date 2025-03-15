'''
- Encapsulates different alghorithms and switches them dynamically
- Used for sorting, payment methods, routing logic

Encapsulates algorithms, allowing them to be swapped dynamically
'''

class PaymentStrategy:
    def pay(self, amount):
        pass

class CreditCardPayment(PaymentStrategy):
    def pay(self, amount):
        return f"Paid {amount} with Credit Card"

class PayPalPayment(PaymentStrategy):
    def pay(self, amount):
        return f"Paid {amount} with PayPal"

class PaymentProcessor:
    def __init__(self, strategy: PaymentStrategy):
        self.strategy = strategy

    def process_payment(self, amount):
        return self.strategy.pay(amount)

# Usage
processor = PaymentProcessor(CreditCardPayment())
print(processor.process_payment(100))  # Output: "Paid 100 with Credit Card"

processor.strategy = PayPalPayment()   # Switching strategy
print(processor.process_payment(50))   # Output: "Paid 50 with PayPal"
