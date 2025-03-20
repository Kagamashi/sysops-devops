package main

import (
	"fmt"
	"os"
)

/* CLI ARGUMENTS
Command-line arguments are a common way to parameterize execution of programs.
For example, go run hello.go uses run and hello.go arguments to the go program.

- os.Args - a slice of strings that holds the command-line arguments;
first element os.Args[0] is the program name, and subsequent elements are the actual arguments
*/

func cli_arguments() {

	argsWithProg := os.Args        // os.Args provides access to raw cli arguments
	argsWithoutProg := os.Args[1:] // Arguments without the name/path of the program

	arg := os.Args[3] // We can retrieve individual arguments with normal indexing

	fmt.Println(argsWithProg)
	fmt.Println(argsWithoutProg)
	fmt.Println(arg)

	/*
		$ go build cli_arguments.go
		$ ./cli_arguments a b c d
		[./cli_arguments a b c d]
		[a b c d]
		c
	*/
}
