package main
import (
	"bufio"
	"fmt"
	"os"
)

func check_wf(e error) {
	if e != nil {
		panic(e)
	}
}

/* 
WRITING FILES
	os.Create(filename) - creates (or truncates) a file for writing and returns a *os.File
	file.Write([]byte) - writes a byre slice to the file
	os.WriteFile(filename, data, perm) - writes data to a file directly
*/

func writing_files() {

	d1 := []byte("hello\ngo\n")                // Creates a byte slice containing string "hello\ngo\n"
	err := os.WriteFile("/tmp/dat1", d1, 0644) // Write byte slice 'd1' to a new file /tmp/dat1. File permissions are set to 0644
	check_wf(err)

	f, err := os.Create("/tmp/dat2") // Create new file /tmp/dat2. If file already exists it will be truncated (emptied)
	check_wf(err)

	defer f.Close() // Defer the closing of the file 'f' until the function exits

	d2 := []byte{115, 111, 109, 101, 10} // Create byte slice 'd2' that constains the ASCII values of 'some' word
	n2, err := f.Write(d2)               // Write byte slice 'd2' to file f. Number of bytes written is stored in n2.
	check_wf(err)
	fmt.Printf("wrote %d bytes\n", n2)
	// wrote 5 bytes

	n3, err := f.WriteString("writes\n") // Write string to file f. Number of bytes written is stored in n3.
	check_wf(err)
	fmt.Printf("wrote %d bytes\n", n3)
	// wrote 7 bytes

	f.Sync() // Sync to flush writes to stable storage

	w := bufio.NewWriter(f) // Create new buffered writer 'w' that wraps around file f
	n4, err := w.WriteString("buffered\n")
	check_wf(err)
	fmt.Printf("wrote %d bytes\n", n4)
	// wrote 9 bytes

	w.Flush() // Flush to ensure all buffered operations have been applied to the underlying writer

	// > cat /tmp/dat1
	// hello
	// go

	// > cat /tmp/dat2
	// some
	// writes
	// buffered

}
