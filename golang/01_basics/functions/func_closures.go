package main
import "fmt"

/* 
Closure is an anonymous function that captures variables from its surrounding scope.
- Closures can maintain state between function calls.
- Anonymous functions are useful when we want to define a function inline without having to name it
*/

func intSeq() func() int { //this function returns another function defined anonymously inside it
	i := 0
	return func() int {
		i++
		return i
	}
}

func closures() {

	nextInt := intSeq() //we call intSeq assigning the result (a function) to nextInt
	// this function value captures its own 'i' value, that will be updated each time we call nextInt

	fmt.Println(nextInt())
	// 1
	fmt.Println(nextInt())
	// 2
	fmt.Println(nextInt())
	// 3

	newInts := intSeq() // state is unique to particular function
	fmt.Println(newInts())
	// 1

}
