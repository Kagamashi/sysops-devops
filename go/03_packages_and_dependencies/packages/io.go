package main 
import (
	"io"
	"os"
	"fmt"
)

/*
io package provides interfaces and utilities for input and output operations

io.ReadAll(file) reads entine content of a file
io.Copy(dst, src) copies data from source to destination (useful for streaming data)
*/

func io_package() {
	file, err := os.Create("example.txt")

	data, err := io.ReadAll(file)
	if err != nil {
		fmt.Println("Error reading file:", err)
		return
	}
	fmt.Println("File content:", string(data))

}
