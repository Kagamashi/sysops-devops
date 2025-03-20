package main

import (
	"flag" // flag package
	"fmt"
)

/* CLI FLAGS
flag package provides more advanced way to parse flags and options from the command line
- flag.Parse() must be called to parse command-line flags
- Flags can be strings, integers, booleans etc. and can have default values and usage description
*/

func cli_flags() {

	wordPtr := flag.String("word", "foo", "a string") // Declare string flag 'word' with default value 'foo' and short description - flag.String function returns string pointer (not a string value)

	numbPtr := flag.Int("numb", 42, "an int") // Declare int flag 'numb' with default value '42'
	forkPtr := flag.Bool("fork", false, "a bool")

	var svar string                                      // It's also possible to declare an option that uses an existing var
	flag.StringVar(&svar, "svar", "bar", "a string var") // Pass a pointer to flag declaration function

	flag.Parse() // Once all flags are declared, flag.Parse() is called to execute cli parsing

	fmt.Println("word:", *wordPtr) // Dereference pointers with * to get actual option values
	fmt.Println("numb:", *numbPtr)
	fmt.Println("fork:", *forkPtr)
	fmt.Println("svar:", svar)
	fmt.Println("tail:", flag.Args()) // Trailing positional arguments can be provided after any flags
	// flag package requires all flags to appear before positional arguments (otherwise flags will be interpreted as positional arguments)

	/*
		$ go build cli_flags.go
		$ ./cli_flags -word=opt -numb=7 -fork -svar=flag
		word: opt
		numb: 7
		fork: true
		svar: flag
		tail: []

		$ ./cli_flags -word=opt
		word: opt
		numb: 42
		fork: false
		svar: bar
		tail: []

		$ ./cli_flags -word=opt a1 a2 a3
		word: opt
		...
		tail: [a1 a2 a3]

		$ ./cli_flags -word=opt a1 a2 a3 -numb=7
		word: opt
		numb: 42
		fork: false
		svar: bar
		tail: [a1 a2 a3 -numb=7"]

		$ ./cli_flags -h
		Usage of ./command-line-flags:
			-fork=false: a bool
			-numb=42: an int
			-svar="bar": a string var
			-word="foo": a string

		$ ./cli_flags -wat
		flag provided but not defined: -wat
		Usage of ./command-line-flags:
		...
	*/

}
