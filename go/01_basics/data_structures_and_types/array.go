package main
import "fmt"

/*
Arrays are fixed-size, ordered collections of elements of the same type
var arr [5]int
arr := [3]int{1, 2, 3}

- Length is part of the array type and cannot change
- Elements can be accessed using zero-based indexing
		arr[0]
- Arrays are copied when passed to functions or assigned to variables
*/

func arrays() {

	var a [5]int //array that holds exactly 5 ints
	fmt.Println("emp:", a)
	// emp: [0 0 0 0 0]

	a[4] = 100 // array[index] = values
	fmt.Println("set:", a)
	fmt.Println("get:", a[4])
	// set: [0 0 0 0 100]
	// get: 100

	fmt.Println("len:", len(a)) //built-in function; returns length of an array
	// len: 5

	b := [5]int{1, 2, 3, 4, 5} //declare and initialize an array in one line
	fmt.Println("dcl:", b)
	// dcl: [1 2 3 4 5]

	b = [...]int{1, 2, 3, 4, 5} //with ... compiler will count the number of elements for us
	fmt.Println("dcl:", b)
	// dcl: [1 2 3 4 5]

	b = [...]int{100, 3: 400, 500} //if we specify the index with :, the elements in between will be zeroed
	fmt.Println("idx:", b)
	// idx: [100 0 0 400 500]

	var twoD [2][3]int // array types are one-dimensional; but can be composed into multi-dimensional data structures
	for i := 0; i < 2; i++ {
		for j := 0; j < 3; j++ {
			twoD[i][j] = i + j
		}
	}
	fmt.Println("2d: ", twoD)
	// 2d: [[0 1 2] [1 2 3]]

	twoD = [2][3]int{ // create and initialize multi-dimensional arrays at once
		{1, 2, 3},
		{1, 2, 3},
	}
	fmt.Println("2d: ", twoD)
	// 2d: [[1 2 3] [1 2 3]]

}
