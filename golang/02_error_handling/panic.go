package main
import "os"

/*
Panic is used to immediately stop the execution of the current function, unwind the stack, terminate the program - unless recovered.
used for unrecoverable errors or critical failures.

Use when:
- critical issues
- unexpected logic failure (should never happen)
- fatal exit functions like log.Fatal
- during development for debugging edge cases

Avoid when:
- common errors
- library functions
- validating user input
- when 
*/

func panic_er() {
	_, err := os.Create("/tmp/file")
	if err != nil {
		panic(err)
	}

	panic("a problem")
}
