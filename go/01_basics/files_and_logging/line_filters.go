package main
import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

/*
Line filter is a common type of program that reads input on stdin, processes it, and then prints some derived result to stdout
- Useful for reading large files or streams line by line and transforming the data on-the-fly
- grep and sed are common line filters

- Common functions:
scanner.Text() - retrieves current line as string
bufio.NewScanner(input) - reads data line by line
*/

func line_filters() {

	scanner := bufio.NewScanner(os.Stdin) // Wrapping unbuffered os.Stdin with buffered scanner gives us convenient Scan method

	for scanner.Scan() { // Text returns the current token, here the next line, from the input

		ucl := strings.ToUpper(scanner.Text())

		fmt.Println(ucl) // Write out the uppercased line
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "error:", err)
		os.Exit(1)
	}

	/*
		> echo 'hello' > /tmp/lines
		> echo 'filter' >> /tmp/lines
		> cat /tmp/lines | go run line_filters.go
		HELLO
		FILTER
	*/

}
