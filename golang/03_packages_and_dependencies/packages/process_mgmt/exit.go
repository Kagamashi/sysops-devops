package main

import (
	"fmt"
	"os"
)

/* EXIT
Use os.Exit to immediately terminate the Go program with a specific exit code.

Exiting a program is done using the os.Exit function, which terminates the current Go program immediately with a specified exit code.
- os.Exit(code int) - terminates the program with the provided exit code.
A non-zero exit code indicates an error, while 0 means success.
- Defer statements, such as closing files or cleaning up resource, will not be executed after calling os.Exit
*/

func exit() {

	defer fmt.Println("!") // defers will not be run when using os.Exit - so this fmt.Println will never be called

	os.Exit(3) // exit with status 3

	/*
		$ go run exit.go		// if we run exit.go using go run exit will be picked up by go and printed
		exit status 3

		go build exit.go		// by building an executing a binary we can see the status in the terminal
		./exit
		echo $?
		3
	*/

}
