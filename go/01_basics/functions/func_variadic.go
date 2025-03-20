package main
import "fmt"

/*
Variadic functions accept a variable number of arguments.
- Syntax: use ... before the parameter type to indicate variadic parameters
- For example fmt.Println is a common variadic function
- Slice can be passed to function using variadic operator ...
sum(slice...)
*/

func sum(nums ...int) { //take arbitrary number of ints as arguments
	fmt.Print(nums, " ")
	total := 0

	for _, num := range nums { //within the function the type of nums is equivalent to []int
		total += num //we can call len(nums), iterave over it with range etc.
	}
	fmt.Println(total)
}

func variadic_functions() {

	sum(1, 2) // variadic functions can be called in the usual way with individual arguments
	// [1 2] 3

	sum(1, 2, 3)
	// [1 2 3] 6

	nums := []int{1, 2, 3, 4} //if we already have multiple args in a slice
	sum(nums...)              // func(slice...)
	// [1 2 3 4] 10

}
