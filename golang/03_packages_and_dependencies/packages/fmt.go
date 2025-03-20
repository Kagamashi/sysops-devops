package main 
import "fmt"

/* 
fmt package provides functions for formatted I/O, including printing to the console and reading input

printing functions:
	fmt.Print() without newline
	fmt.Println() with newline
	fmt.Printf() formatted output

formatting functions (it doesn't print the string):
	fmt.Sprintf() returns formatted string
	fmt.Sprintln() + newline

scanning functions (input handling):
	fmt.Scan() reads space-separated values
	fmt.Scanln() reads input until a newline
	fmt.Scanf() reads formatted input

%v values (default format)
	%s string
	%f float
	%d integer
%c character represented by rune
%U Unicode code point
%+v include struct field names
%#v Go syntax representation of the value (source code snippet)
%T type of the value
%x provides HEX encoding
%q to double quote strings
%p representation of a pointer
%b binary representation
*/

func fmt_package() {
	fmt.Println("This is a new line.")

	name := "John"
	age := 30
	fmt.Printf("My name is %s and I am %d years old.\n", name, age)

	formattedString := fmt.Sprintf("The price is %.2f dollars.", 19.99)
	fmt.Println(formattedString)

	str1 := fmt.Sprintln("This is", "a combined string.")
	fmt.Println(str1)
}

type point struct {
	x, y int
}

func string_formatting() { // main
	p := point{1, 2}

	fmt.Printf("struct1: %v\n", p) // struct1: {1 2}

	fmt.Printf("struct2: %+v\n", p) // struct2: {x:1, y:2}

	fmt.Printf("struct3: %#v\n", p) // struct3: main.point{x:1, y:2}

	fmt.Printf("type: %T\n", p)	// type: main.point

	fmt.Printf("bool: %t\n", true) // bool: true

	fmt.Printf("int: %d\n", 123) // int: 132

	fmt.Printf("bin: %b\n", 14) // bin: 1110

	fmt.Printf("char: %c\n", 33) // char: !

	fmt.Printf("hex: %x\n", 456) // hex: 1c8

	fmt.Printf("float1: %f\n", 78.9) // float1: 78.900000

	fmt.Printf("float2: %e\n", 123400000.0) // float2: 1.234000e+08

	fmt.Printf("float3: %E\n", 123400000.0) // float3: 1.234000E+08

	fmt.Printf("str1: %s\n", "\"string\"") // str1: "string"

	fmt.Printf("str2: %q\n", "\"string\"") // str2: "\"string\""

	fmt.Printf("str3: %x\n", "hex this") // str3: 6865782074686973

	fmt.Printf("pointer: %p\n", &p) // pointer: 0xc0000ba000

	fmt.Printf("width1: |%6d|%6d|\n", 12, 345) // width1: |    12|   345|

	fmt.Printf("width2: |%6.2f|%6.2f|\n", 1.2, 3.45) // width2: |  1.20|  3.45|

	fmt.Printf("width3: |%-6.2f|%-6.2f|\n", 1.2, 3.45) // width3: |1.20  |3.45  |

	fmt.Printf("width4: |%6s|%6s|\n", "foo", "b") // width4: |   foo|     b|

	fmt.Printf("width5: |%-6s|%-6s|\n", "foo", "b") // width5: |foo   |b     |
}
