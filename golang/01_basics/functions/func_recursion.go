package main
import "fmt"

/* 
recursive function calls itself directly or indirectly to solve problems that can be broken down into subproblems.
- Base case is essential to prevent infinite recursion.
*/

func fact(n int) int { // this fact function calls itself until it reaches the base case of fact(0)
	if n == 0 {
		return 1
	}
	return n * fact(n-1)
}

func recursion() {
	fmt.Println(fact(7))
	// 5040

	var fib func(n int) int //closures can also be recursive, but this requires the closure to be declared with a typed var explicitly before its defined

	fib = func(n int) int {
		if n < 2 {
			return n
		}

		return fib(n-1) + fib(n-2)
	}

	fmt.Println(fib(7))
	// 13

}
