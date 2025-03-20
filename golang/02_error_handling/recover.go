package main
import "fmt"

/*
Recover is used to regain control of a panicking goroutine, effectively stopping the panic and preventing the program from crashing.

- Recover only works inside deferred functions - if called during a panic, it catches the panic and allows the program to continue
- If there's no panic recover returns nil
- Used for graceful error recovery, especially in servers or critical systems where abrupt termination must be avoided
*/

func mayPanic() { // function that deliberately causes a panic
	panic("a problem")
}

func recover_er() {
	defer func() { // Use defer to set up a recovery function in case of a panic
		if r := recover(); r != nil { // Recover call will catch the panic
			fmt.Println("Recovered. Error:\n", r)
		}
	}()

	mayPanic() // Call the function that caused a panic

	fmt.Println("After mayPanic()") // This line would not be reached if a panic is not recovered, because the program will crash

	// Recovered. Error:
	// 	a problem
}
