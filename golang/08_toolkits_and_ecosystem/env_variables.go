package main
import (
	"fmt"
	"os"
	"strings"
)

/* ENVIRONMENTAL VARIABLES
Environmental variables are a universal mechanism for conveying configuration information to Unix programs.
https://en.wikipedia.org/wiki/Environment_variable
https://www.12factor.net/config

Common functions:
	os.Getenv(key) - retrieves the value of the environment variable key - returns empty string if key is not found
	os.Setenv(key, value) - sets or updates the environment variable key with given value
	os.Unsetenv(key) - remove environment variable key
	os.LookupEnv(key) - similar to os.Getenv, but returns a second boolean value indicating whether the key was found
	os.Environ() - list all environment variables in environment
*/

func env_variables() {

	os.Setenv("FOO", "1")                 // Set key/value pair
	fmt.Println("FOO:", os.Getenv("FOO")) // Get value of environmental variable 'FOO'
	fmt.Println("BAR:", os.Getenv("BAR"))

	fmt.Println()
	for _, e := range os.Environ() { // This returns slice of strings in form KEY=value.
		pair := strings.SplitN(e, "=", 2) // strings.SplitN to get key and value
		// fmt.Println(pair[0]) // To print just the keys
		fmt.Printf("%s=%s\n", pair[0], pair[1]) // Print keys and values
	}

	/*
		$ go run env_variables.go
		FOO: 1
		BAR: 0

		MallocNanoZone
		USER
		COMMAND_MODE
		__CFBundleIdentifier
		...
		FOO

		$ BAR=2 go run env_variables.go
		FOO: 1
		BAR: 2
		...
	*/
}
