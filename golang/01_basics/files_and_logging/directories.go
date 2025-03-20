package main
import (
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
)

/* 
DIRECTORIES
os package provides functions for creating, removing and reading directories

Common functions:
	os.Mkdir(name, perm) - creates directory with specified permissions
	os.RemoveAll(path) - removes a directory and all of its contents
	os.ReadDir(path) - reads the contents of a directory and returns a list of directory entries
	os.Chdir(path) - change working directory to path
	filepathj.WalkDir
	entry.IsDir
*/

func directories() {

	err := os.Mkdir("subdir", 0755) // Create new sub-directory
	check_dir(err)

	defer os.RemoveAll("subdir") // Remove directory subdir after whole function runs

	createEmptyFile := func(name string) { // Helper function to create new empty file
		d := []byte("")
		check_dir(os.WriteFile(name, d, 0644))
	}

	createEmptyFile("subdir/file1") // Create empty file

	err = os.MkdirAll("subdir/parent/child", 0755) // We can create a hierarchy of directories, including parents with MkdirAll - similar to command-line 'mkdir -p'
	check_dir(err)

	createEmptyFile("subdir/parent/file2")
	createEmptyFile("subdir/parent/file3")
	createEmptyFile("subdir/parent/child/file4")

	c, err := os.ReadDir("subdir/parent") // Lists directory contents returning a slice of os.DirEntry object
	check_dir(err)

	fmt.Println("Listing subdir/parent")
	for _, entry := range c {
		fmt.Println(" ", entry.Name(), entry.IsDir()) // Checks if outputed objects are directories or not
	}
	/* Listing subdir/parent
	child true
	file2 false
	file3 false
	*/

	err = os.Chdir("subdir/parent/child") // Chdir lets us change the surrect working directory - similarly to 'cd'
	check_dir(err)

	c, err = os.ReadDir(".")
	check_dir(err)

	fmt.Println("Listing subdir/parent/child")
	for _, entry := range c {
		fmt.Println(" ", entry.Name(), entry.IsDir())
	}
	/* Listing subdir/parent/child
	file 4 false
	*/

	err = os.Chdir("../../..")
	check_dir(err)

	fmt.Println("Visiting subdir")
	err = filepath.WalkDir("subdir", visit) // Visit directory recursively, including all its sub-directories
	/* Visiting subdir
	subdir true
	subdir/file1 false
	subdir/parent true
	subdir/parent/child true
	subdir/parent/child/file4 false
	subdir/parent/file2 false
	subdir/parent/file3 false
	*/

}

func visit(path string, d fs.DirEntry, err error) error { // WalkDir accepts a callback function to handle every file or directory visited
	if err != nil { // visit is called for every file or directory found recursively by filepath.WalkDir
		return err
	}
	fmt.Println(" ", path, d.IsDir())
	return nil
}

func check_dir(e error) {
	if e != nil {
		panic(e)
	}
}
