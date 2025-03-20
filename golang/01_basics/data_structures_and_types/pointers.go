package main
import "fmt"

/* POINTERS
- Pointers hold the memory address of a value
- Declared using:
* (dereference operator) var ptr *int
& (address-of-operator) ptr = &x  //ptr holds the value of x
- Go doesn't support pointer arithmetic (like in C or C++)
- We can use pointers to pass references to function which enables us to modify variables outside of the function
- ! always ensure a pointer is not nil before dereferencing to avoid runtime panics
*/

/*
zeroval has an int parameter, so arguments will be passed to it by value
zeroval will get a copy of ival distinct from the one in the calling function
*/
func zeroval(ival int) {
	ival = 0
}

/*
zeroptr has an *int parameter, it takes an int pointer
the *iptr code in the function body then dereferences the pointer from its memory adddress to the current value at that address
assigning a value to a dereferenced pointer changes the value at the referenced address
*/
func zeroptr(iptr *int) {
	*iptr = 0
}

func pointer() {
	i := 1
	fmt.Println("initial:", i)
	// initial: 1

	zeroval(i)
	fmt.Println("zeroval:", i)
	// zerova: 1

	zeroptr(&i) // &1 syntax gives the memory address of i, i.e. a pointer to i
	fmt.Println("zeroptr:", i)
	// zeroptr: 0

	fmt.Println("pointer:", &i) //pointers can be printed
	// pointer: 0x42131100

	// zeroval doesn't change the i in main, but zeroptr does because it has a reference to the memory address for that variable

	var ptr *int

	x := 42  // here we are obtaining the address
	ptr = &x // ptr holds now the adress of x

	fmt.Println(*ptr)
	// 42

	*ptr = 100 // here we can modify the value at pointers address

	fmt.Println(*ptr)
	// 100
}
