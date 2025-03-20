package main
import (
	"fmt"
	"strconv" // https://pkg.go.dev/strconv
)

/*
strconv package handles numbers parsing which converts strings to numeric types and vice versa.

strconv.Atoi(s string) - converts string to an integer (int).
strconv.ParseFloat(s string, bitSize int) - converts string to floating-point number; bitSize specified precision (32 or 64 bits)
strconv.ParseInt(s string, base int, bitSize int) - converts string to integer of specified base (base 10 for decimal, 16 for hexadecimal)
strconv.FormatInt / strconv.FormatFloat - convert numbers back to string
*/

func number_parsing() {

	f, _ := strconv.ParseFloat("1.234", 64)
	fmt.Println(f)
	// 1.234

	i, _ := strconv.ParseInt("123", 0, 64)
	fmt.Println(i)
	// 123

	d, _ := strconv.ParseInt("0x1c8", 0, 64) // ParseInt recognize hex formatted numbers
	fmt.Println(d)
	// 456

	u, _ := strconv.ParseUint("789", 0, 64)
	fmt.Println(u)
	// 789

	k, _ := strconv.Atoi("135") // Atoi is a convenience function for basic base-10 int parsing
	fmt.Println(k)
	// 135

	_, e := strconv.Atoi("wat") // Parse functions return an error on bad input
	fmt.Println(e)
	// strconv.ParseInt: parsing "wat": invalid syntax

}
