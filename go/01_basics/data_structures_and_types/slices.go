package main
import (
	"fmt"
	"slices"
)

/*
Slices are dynamic, resizable arrays that provide more flexibility than arrays.
var s []int
s := []int{1, 2, 3}
s = make([]int, 3)

- Slices can grow and shrink in size
- Slices are references to an underlying array - modifying the slice modifies the array
- Slices can be created from arrays or other slices
		s := arr[1:3]

Built-in functions
	len(s)  length of the slice
	cap(s)  capacity of the slice (size of underlying array)
	append(s, elem)  add elements to a slice
*/

func slice() {

	var s []string                                   //slices are typed only by the elements they contain (not the number of elements)
	fmt.Println("uninit:", s, s == nil, len(s) == 0) //unitialized slice equals to nil and has length 0
	// uninit: [] true true

	s = make([]string, 3) //we can create empty slice with non-zero length using builtin function make
	fmt.Println("emp:", s, "len:", len(s), "cap:", cap(s))
	// emp: [   ]  len: 3  cap: 3

	s[0] = "a" //we can set and get just like with arrays
	s[1] = "b"
	s[2] = "c"
	fmt.Println("set:", s)
	// set: [a b c]
	fmt.Println("get:", s[2])
	// get: c

	fmt.Println("len:", len(s)) //len returns the length of slice as expected
	// len: 3

	s = append(s, "d") //append adds values to the slice
	s = append(s, "e", "f")
	fmt.Println("apd:", s)
	// apd: [a b c d e f]

	c := make([]string, len(s)) //create slice c with the same length as slice s
	copy(c, s)                  //copy the values
	fmt.Println("cpy:", c)
	// cpy: [a b c d e f]

	l := s[2:5] //slices support "slice" operator with syntax slice[low:high]
	fmt.Println("sl1:", l)
	// sl1: [c d e]

	l = s[:5] //slices up to (but excluding) s[5]
	fmt.Println("sl2:", l)
	// sl2: [a b c d e]

	l = s[2:] //slices up from (and including) s[2]
	fmt.Println("sl3:", l)
	// sl3: [c d e f]

	t := []string{"g", "h", "i"} //we can declare and initialize a variable for slice in a single line as well
	fmt.Println("dcl:", t)
	// dcl: [g h i]

	t2 := []string{"g", "h", "i"}
	if slices.Equal(t, t2) { //package slices contain useful utilities functions for slices
		fmt.Println("t == t2")
	}

	twoD := make([][]int, 3) //slices can be composed into multi-dimensional data structures
	for i := 0; i < 3; i++ { //the length of the inner slices can vary, unlike with multi-dimensional arrays
		innerLen := i + 1
		twoD[i] = make([]int, innerLen)
		for j := 0; j < innerLen; j++ {
			twoD[i][j] = i + j
		}
	}
	fmt.Println("2d: ", twoD)
	// 2d: [[0] [1 2] [2 3 4]]
}
