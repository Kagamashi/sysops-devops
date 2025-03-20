package main
import (
	"bufio"
	"fmt"
	"io"
	"os"
)

/*
os and io/ioutil packages provide functions to read data from files in Go
- Common functions:
os.ReadFile(filename) - reads the entire file into a byte slice
file.Read([]byte) - reads a specific number of bytes into a slice from an open file
bufio.NewScanner(file) - reads the file line by line for large files
io.SeekCurrent
io.SeekEnd
io.SeekStart
*/

func check_rf(e error) { // Reading files requires checking most calls for errors
	if e != nil {
		panic(e)
	}
}

func reading_files() {
	// echo "hello" > /tmp/dat
	// echo "go" >> /tmp/dat

	dat, err := os.ReadFile("/tmp/dat")
	check_rf(err)
	fmt.Print(string(dat))
	// hello
	// go

	f, err := os.Open("/tmp/dat") // os.Open returns file descriptor 'f' that can be used for further file operations
	check_rf(err)

	b1 := make([]byte, 5) // Create a byte slice (buffer) of size 5 and read the first 5 bytes from the file
	n1, err := f.Read(b1) // Read up to 5 bytes into b1, number of bytes actually read is stored in n1
	check_rf(err)
	fmt.Printf("%d bytes: %s\n", n1, string(b1[:n1])) // Print how many bytes were read and the content
	// 5 bytes: hello

	o2, err := f.Seek(6, io.SeekStart) // f.Seek moves file pointer to 6th byte from the start and returns new position (stored in o2)
	check_rf(err)
	b2 := make([]byte, 2) // Create new byte slice (buffer) of length 2
	n2, err := f.Read(b2) // Read 2 bytes from the file at the current file pointer position (which is now at byte 6)
	check_rf(err)
	fmt.Printf("%d bytes @ %d: ", n2, o2) // Print how many bytes were read and the position
	// 2 bytes @ 6:
	fmt.Printf("%v\n", string(b2[:n2])) // Print the content
	// go

	_, err = f.Seek(4, io.SeekCurrent) // Move file pointer 4 bytes forward
	check_rf(err)

	_, err = f.Seek(-10, io.SeekEnd) // Move file pointer to 10 bytes before the end of the file
	check_rf(err)

	o3, err := f.Seek(6, io.SeekStart) // Seek to the 6th byte from the start again
	check_rf(err)
	b3 := make([]byte, 2)
	n3, err := io.ReadAtLeast(f, b3, 2) // Read at least 2 bytes from the current file pointer position into 'b3'. Number of bytes read is stored in 'n3'
	check_rf(err)
	fmt.Printf("%d bytes @ %d: %s\n", n3, o3, string(b3))
	// 2 bytes @ 6: go

	_, err = f.Seek(0, io.SeekStart) // Seek back to the start of the sile
	check_rf(err)

	r4 := bufio.NewReader(f) // Create buffered reader for more efficient reading
	b4, err := r4.Peek(5)    // Peek at the next 5 bytes without moving the file pointer
	check_rf(err)
	fmt.Printf("5 bytes: %s\n", string(b4))
	// 5 bytes: hello

	f.Close() // Close the file - usually would be scheduled immediately after Opening with defer

}
