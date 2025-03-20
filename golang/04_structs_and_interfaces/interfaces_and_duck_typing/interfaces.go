package main
import (
	"fmt"
	"math"
)

/*
Interfaces in Go define a set of method signatures that types must implement to satisfy the interface.
- Type implemenets an interface if it has all the methods required by that interface. No explicit declaration is needed.
	type InterfaceName interface {
			MethodName(parameters) returnType
	}

- Emmpty interface (interface{}) can be used to represent any type, as all types implement it
- Type asssertions can be used to exract the underlying type from an interface
	value := interfaceVariable.(ConcreteType)
- Type switch allows branching logic based on the concrete type stored in an interface
	switch v := i.(type) {
			case string:
					// handle string type
	}
- Zero value of an interface is 'nil' - no concrete value or type is stored
- Functions can accept interfaces as parameters, allowing flexible and polymorphic behavior
- Interfaces can embed other interfaces to create more complex interfaces (compositions)

https://jordanorelli.com/post/32665860244/how-to-use-interfaces-in-go
*/

// Define an interface
type Shape interface {
	Area() float64
}

// Struct: Circle
type Circle struct {
	Radius float64
}

// Struct: Rectangle
type Rectangle struct {
	Width, Height float64
}

// Implement Area() method for Circle
func (c Circle) Area() float64 {
	return 3.14 * c.Radius * c.Radius
}

// Implement Area() method for Rectangle
func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

// Function using polymorphism (any Shape)
func PrintArea(s Shape) {
	fmt.Println("Area:", s.Area())
}

func main() {
	c := Circle{Radius: 5}
	r := Rectangle{Width: 4, Height: 6}

	// Polymorphic behavior: Different types, same method call
	PrintArea(c) // Output: Area: 78.5
	PrintArea(r) // Output: Area: 24
}

