package main
import (
	"fmt"
	"os"
	"path/filepath"
)

/* 
TEMPORARY FILES/DIRECTORIES
Go provides functions to create temporary files and directories, typically used for testing or short-lived operations

- Common functions:
os.CreateTemp(dir, pattern) - creates temporary file in specified directory
os.MkdirTemp(dir, pattern) - creates temporary directory
- Temporary files and directories are automatically deleted when the program terminates (if properly cleaned up)
*/

func temporary_files_and_directories() {

	f, err := os.CreateTemp("", "sample") // CreateTemp to create a temporary file - first argument is "" to create file in default location
	check_tfd(err)

	fmt.Println("Temp file name:", f.Name()) // Display the name of temporary file - filename starts with the prefix given as argument
	// Temp file name: /tmp/sample62343223

	defer os.Remove(f.Name()) // Good practice to clean the files - even tho they should be deleted automatically

	_, err = f.Write([]byte{1, 2, 3, 4}) // Write data to the file
	check_tfd(err)

	dname, err := os.MkdirTemp("", "sampledir") // MkdirTemp creates temporary directory
	check_tfd(err)
	fmt.Println("Temp dir name:", dname)
	// Temp dir name: /tmp/sampledir898854668

	defer os.RemoveAll(dname)

	fname := filepath.Join(dname, "file1") // Synthesize temporary file names by prefixing them with temporary directory
	err = os.WriteFile(fname, []byte{1, 2}, 0666)
	check_tfd(err)

}

func check_tfd(e error) {
	if e != nil {
		panic(e)
	}
}
