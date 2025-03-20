package main
import "fmt"

/*
Factory Pattern is used to create objects without exposing the instantiation logic

Useful when:
- the object creation process is complex
- we need to return a specific implementation of an interface

✅ Encapsulates object creation
✅ Supports multiple implementations
*/

// Payment interface
type Payment interface {
    Pay(amount float64)
}

// CreditCard struct
type CreditCard struct{}

func (c CreditCard) Pay(amount float64) {
    fmt.Println("Paid", amount, "using Credit Card")
}

// PayPal struct
type PayPal struct{}

func (p PayPal) Pay(amount float64) {
    fmt.Println("Paid", amount, "using PayPal")
}

// Factory function
func NewPaymentMethod(method string) Payment {
    switch method {
    case "credit":
        return CreditCard{}
    case "paypal":
        return PayPal{}
    default:
        return nil
    }
}

func factory_pattern() {
    payment := NewPaymentMethod("credit")
    if payment != nil {
        payment.Pay(100)
    }
}
