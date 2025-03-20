package main 
import "fmt"

/* go supports functional programming concepts like:

closures: functions inside functions that capture variables
- maintain state without using global variables
- useful for counters, caching, lazy evaluation

higher-order functions: functions that accept or return other functions
- mapping and filtering data (e.g. map, filter)
- functional composition (chaining functions)
- custom processing logic (e.g. retry mechanisms)
*/

// CLOSURE
func Counter() func() int {
	count := 0
	return func() int { // Closure capturing `count`
		count++
		return count
	}
}

func counter_func() {
	next := Counter()
	fmt.Println(next()) // Output: 1
	fmt.Println(next()) // Output: 2
	fmt.Println(next()) // Output: 3
}


// HIGHER-ORDER FUNCTION
func Apply[T any](value T, fn func(T) T) T {
	return fn(value)
}

func higher_order_func() {
	square := func(n int) int { return n * n }
	fmt.Println(Apply(4, square)) // Output: 16

	toUpper := func(s string) string { return strings.ToUpper(s) }
	fmt.Println(Apply("hello", toUpper)) // Output: HELLO
}
