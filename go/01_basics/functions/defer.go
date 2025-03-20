package main
import (
	"fmt"
	"os"
)

/*
Defer schedules a function to be executed after the surrounding function returns, typically used for resource clean (e.g. closing files or unlocking mutexes)
func main() {
    defer fmt.Println("This will print last.")
    fmt.Println("This prints first.")
}

- Deferred functions are executed in LIFO order, just before the function returns
- Defer is useful for closing resources ensuring the cleanup always happens regardless of how the function exits.
*/

func defer_er() {

	f := createFile("/tmp/defer.txt") // Create a file at provided path and store file pointer in 'f'
	defer closeFile(f)                // Use defer to ensure the file is closed at the end of the main function
	writeFile(f)
	// creating
	// writing
	// closing
}

func createFile(p string) *os.File {
	fmt.Println("creating")
	f, err := os.Create(p)
	if err != nil {
		panic(err)
	}
	return f // return file pointer to use by other functions
}

func writeFile(f *os.File) {
	fmt.Println("writing")
	fmt.Fprintln(f, "data") // write string "data" into the file
}

func closeFile(f *os.File) {
	fmt.Println("closing")
	err := f.Close() // attempt to close the file

	if err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
}
