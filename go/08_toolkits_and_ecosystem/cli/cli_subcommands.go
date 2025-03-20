package main

import (
	"flag"
	"fmt"
	"os"
)

/* CLI SUBCOMMANDS
flag package lets us easily define simple subcommands that have their own flags
- go build and go get are two different subcommands of the go tool

- Common functions:
flag.NewFlagSet() - declare new subcommand
fooCmd.Bool() - declare flag of boolean type for 'foo' subcommand
*/

func cli_subcommands() {

	fooCmd := flag.NewFlagSet("foo", flag.ExitOnError)  // Declare a subcommand using NewFlagSet function
	fooEnable := fooCmd.Bool("enable", false, "enable") // Declare flag specific to 'foo' subcommand
	fooName := fooCmd.String("name", "", "name")

	barCmd := flag.NewFlagSet("bar", flag.ExitOnError) // Declare 'bar' subcommand
	barLevel := barCmd.Int("level", 0, "level")

	if len(os.Args) < 2 { // Subcommand is expected as the first arguments to the program
		fmt.Println("expected 'foo' or 'bar' subcommands")
		os.Exit(1)
	}

	switch os.Args[1] { // Check which subcommand is invoked

	case "foo":
		fooCmd.Parse(os.Args[2:])
		fmt.Println("subcommand 'foo'")
		fmt.Println("  enable:", *fooEnable)
		fmt.Println("  name:", *fooName)
		fmt.Println("  tail:", fooCmd.Args())
	case "bar":
		barCmd.Parse(os.Args[2:])
		fmt.Println("subcommand 'bar'")
		fmt.Println("  level:", *barLevel)
		fmt.Println("  tail:", barCmd.Args())
	default:
		fmt.Println("expected 'foo' or 'bar' subcommands")
		os.Exit(1)
	}

	/*
		$ go build cli_subcommands.go
		$ ./cli_subcommands  foo -enable -name=joe a1 a2
		subcommand 'foo'
			enable: true
			name: joe
			tail: [a1 a2]

		$ ./cli_subcommands bar -level 8 a1
		subcommand 'bar'
			level: 8
			tail: [a1]

		$ ./cli_subcommands bar -enable a1
		flag proided but not defined: -enable
		Usage of bar:
			- level int
				level
	*/

}
