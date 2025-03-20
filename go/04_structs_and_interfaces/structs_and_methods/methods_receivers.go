package main
import "fmt"

/*
Value receivers (func (t T)): method gets a copy of the struct
	- use when method does not modify the struct
	- suitable for small structs since copying is inexpensive
*/

type Person struct {
	Name string
}

// Method with a value receiver (operates on a copy)
func (p Person) Greet() {
	fmt.Println("Hello, my name is", p.Name)
}

func value_receiver() {
	p := Person{Name: "Alice"}
	p.Greet() // Hello, my name is Alice
}


/*
Pointer receivers (func (t *T)): method gets a reference to the struct
	- use when method modifies the struct
	- struct is large and copying it would be inefficient
	- need to ensure changes persist across function calls
*/

type Counter struct {
	Count int
}

// Method with a pointer receiver (modifies the struct)
func (c *Counter) Increment() {
	c.Count++
}

func main() {
	c := Counter{Count: 5}
	c.Increment()
	fmt.Println(c.Count) // 6
}