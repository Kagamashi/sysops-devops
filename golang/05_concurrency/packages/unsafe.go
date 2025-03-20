package main
import (
	"fmt"
	"unsafe"
)

/*
unsafe package allows low-level memory manipulation but should be used with caution

unsafe.Pointer							Converts between pointer types arbitrarily
uintptr											Stores memory addresses as integers
unsafe.Sizeof(x)						Gets the size of a variable in bytes
unsafe.Offsetof(x.field)		Gets the offset of a struct field

Dangers:
	- Bypasses Go’s memory safety (can cause segmentation faults).
	- Not portable (depends on architecture-specific memory layouts).
	- Future Go versions may break assumptions made using unsafe.
*/

func unsafe_package() {
	var x int = 42
	ptr := unsafe.Pointer(&x)
	newPtr := (*int)(ptr)
	*newPtr = 100
	fmt.Println(x) // Output: 100
}
