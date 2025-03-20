package main
import "fmt"

/*
Methods in Go are functions with a receiver and are associated with a specific type
A receiver is a parameter that appears before the function name and specifies the type to which the method belongs.
func (receiverType receiverName) methodName(parameters) returnType {
  // method body
}
- Methods can be called using the dot notation
instance.methodName(arguments)

Receiver:
- variable of custom type that appears before the method name
- it can be a value receiver or pointer receiver
*/

type rect struct {
	width, height int
}

func (r *rect) area() int { // this area method has a POINTER receiver type - *rect
	return r.width * r.height
}

func (r rect) perim() int { // this perim method has a VALUE receiver type - rect
	return 2*r.width + 2*r.height
}

func methods() {
	r := rect{width: 10, height: 5}

	fmt.Println("area: ", r.area()) // here we call the 2 methods defined for our struct
	// area: 50

	fmt.Println("perim:", r.perim()) // perim: 30

	rp := &r // Go automatically handles conversion between values and pointers for method calls
	fmt.Println("area: ", rp.area()) // area: 50

	fmt.Println("perim:", rp.perim()) // perim: 30
}
