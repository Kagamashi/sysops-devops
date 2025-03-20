package main 
import (
	"os"
	"fmt"
)

/*
os package provides functions for interacting with the operating system including file handling, process management, environment variables

os.Create(filename) – Creates a file
os.Open(filename) – Opens a file for reading
os.Remove(filename) – Deletes a file
os.Stat(filename) – Checks if a file exists
os.Getenv("VAR_NAME") – Retrieves an environment variable
os.Stdin.Read() – Reads input from the user
*/

func os_package() {

	file, err := os.Create("example.txt")
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer file.Close()

	content := "Hello, this is an example file.\n"
	_, err = file.WriteString(content)
	if err != nil {
		fmt.Println("Error writing to file:", err)
		return
	}

	file, err = os.Open("example.txt")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	// getting environment variables
	fmt.Println("Go path:", os.Getenv("GOPATH"))

	// checking if a file exists
	if _, err := os.Stat("example.txt"); err == nil {
		fmt.Println("example.txt exists")
	} else {
		fmt.Println("example.txt does not exist")
	}
}
