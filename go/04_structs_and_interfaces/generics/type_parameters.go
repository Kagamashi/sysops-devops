package main
import "fmt"

/*
type parameter allows a function or struct to work with multiple types insteaf of being restricted to a single type
- generics eliminate the need for duplicated code
- ensures type safety at compile-time
*/

// T is a type parameter
// any is a shorthand for interface{} (i.e. any type)
func FunctionName[T any](param T) T {
    // Function logic
}

// Generic function that works with any type
func Print[T any](value T) {
	fmt.Println(value)
}

func main() {
	Print(42)        // 42
	Print("Hello")   // Hello
	Print(3.14)      // 3.14
}
