package main
import (
	"fmt"
	"unicode/utf8"
)

/*
Runes represent Unicode code points in Go, stored as int32 values
var r rune = "a"

- String in Go are UTF-8 encoded, and runes are used to handle individual Unicode characters
- Conversion - string can be converted to a slice of runes to safely handle multi-byte characters
runes := []rune("hello")

https://go.dev/blog/strings
*/

func string_runes() {

	const s = "สวัสดี" // s is a string assigned a literal value representing the word "hello" in Thai language, Go string literals are UTF-8 encoded text

	fmt.Println("Len:", len(s)) // string are equivalent to []byte, this produces the length of the raw bytes stored within
	// Len: 18

	for i := 0; i < len(s); i++ { // indexing into a string produces the raw byte values at each index
		fmt.Printf("%x ", s[i]) // this loop generates the hex values of all the bytes that constitute the code points in s
	}
	// e0 b8 aa e0 b8 a7 e0 b8 b1 e0 b8 aa e0 b8 94 e0 b8 b5
	fmt.Println()

	fmt.Println("Rune count:", utf8.RuneCountInString(s)) // to count how many runes are in a string we can use utf8 package
	// Rune count: 6

	for idx, runeValue := range s { // a range loop handles strings specially and decoded each rune along with its offset in the string
		fmt.Printf("%#U starts at %d\n", runeValue, idx)
	}
	/*
		U+0E2A 'ส' starts at 0
		U+0E27 'ว' starts at 3
		U+0E31 'ั' starts at 6
		U+0E2A 'ส' starts at 9
		U+0E14 'ด' starts at 12
		U+0E35 'ี' starts at 15
	*/

	fmt.Println("\nUsing DecodeRuneInString") // we can achieve the same iteration using the utf8.DecodeRuneInString function
	for i, w := 0, 0; i < len(s); i += w {
		runeValue, width := utf8.DecodeRuneInString(s[i:])
		fmt.Printf("%#U starts at %d\n", runeValue, i)
		w = width

		examineRune(runeValue) // this demonstrates passing a rune vaue to a function
	}
	/*
		Using DecodeRuneInString
		U+0E2A 'ส' starts at 0
		found so sua
		U+0E27 'ว' starts at 3
		U+0E31 'ั' starts at 6
		U+0E2A 'ส' starts at 9
		found so sua
		U+0E14 'ด' starts at 12
		U+0E35 'ี' starts at 15
	*/
}

func examineRune(r rune) {
	if r == 't' { // values enclosed in single quotes are rune literals. We can compare a rune value to a rune literal directly
		fmt.Println("found tee")
	} else if r == 'ส' {
		fmt.Println("found so sua")
	}
}
