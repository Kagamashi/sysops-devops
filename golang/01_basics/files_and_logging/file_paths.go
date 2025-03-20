package main
import (
	"fmt"
	"path/filepath"
	"strings"
)

/*
path/filepath package provides utilities to work with file and directory paths across different operating systems
- Ensures cross-platform compability when handling file paths

- Common functions:
filepath.Join(elements...) - combines multiple path elements into a single path
filepath.Abs(path) - returns the absolute path of a relative path
filepath.Base(path) - returns the last element of the path (e.g. filename)
*/

func file_paths() {

	p := filepath.Join("dir1", "dir2", "filename") // Join construt paths in portable way - it takes any number of arguments and construct a hierarchical path from them
	fmt.Println("p:", p)
	// p: dir1/dir2/filename

	fmt.Println(filepath.Join("dir1//", "filename")) // Join will normalize paths by removing superfluos separators and directory changes
	fmt.Println(filepath.Join("dir1/../dir1", "filename"))
	// dir/filename
	// dir1/filename

	fmt.Println("Dir(p):", filepath.Dir(p))   // Dir and Base can be used to split a path to the directory and the file
	fmt.Println("Base(p):", filepath.Base(p)) // Alternatively, Split will return both in the same call
	// Dir(p): dir1/dir2
	// Base(p): filename

	fmt.Println(filepath.IsAbs("dir/file")) // We can check whether a path is absolute
	fmt.Println(filepath.IsAbs("/dir/file"))
	// false
	// true

	filename := "config.json"

	ext := filepath.Ext(filename) // Some file have extensions following a dot - we can split extension out of such names with Ext
	fmt.Println(ext)
	// .json

	fmt.Println(strings.TrimSuffix(filename, ext)) // TrimSuffix to get file name with extension removed
	// config

	rel, err := filepath.Rel("a/b", "a/b/t/file") // Rel finds a relative path between a base and a target
	if err != nil {                               // It returns an error if the target cannot be made relative to base
		panic(err)
	}
	fmt.Println(rel)
	// t/file

	rel, err = filepath.Rel("a/b", "a/c/t/file")
	if err != nil {
		panic(err)
	}
	fmt.Println(rel)
	// ../c/t/file

}
