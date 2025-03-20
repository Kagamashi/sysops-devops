package main
import (
	"bytes"
	"fmt"
	"regexp"
)

/* REGULAX EXPRESSIONS
regexp package allows for pattern matching and text manipulation using regular expressions

regexp.MatchString(pattern, s) - returns true if s matches the pattern
regexp.Compile(pattern) - compiles a regular expression for repeated use
re.ReplaceAllString(s, replacement) - replaces parts of s that match the regex
*/

func regular_expressions() {

	match, _ := regexp.MatchString("p([a-z]+)ch", "peach") // MatchString checks if the entire string matches the regular expression pattern
	fmt.Println(match)
	// true

	r, _ := regexp.Compile("p([a-z]+)ch") // Compile creates a Regexp object from the pattern. Efficient for repeated use.

	fmt.Println(r.MatchString("peach"))
	// true

	fmt.Println(r.FindString("peach punch")) // FindString finds the first match of the pattern in the string
	// peach

	fmt.Println("idx:", r.FindStringIndex("peach punch")) // FindStringIndex returns the start and end index of the first match in the string
	// idx: [0 5]

	fmt.Println(r.FindStringSubmatch("peach punch")) // FindStringSubmatch returns full match and submatches (captures groups)
	// [peach ea]

	fmt.Println(r.FindStringSubmatchIndex("peach punch")) // FindStringSubmatchIndex returns index positions of both the full match and submatches
	// [0 5 1 3]

	fmt.Println(r.FindAllString("peach punch pinch", -1)) // FindAllString finds all matches in the string and returns them as a slice of strings
	// [peach punch pinch]

	fmt.Println("all:", r.FindAllStringSubmatchIndex(
		"peach punch pinch", -1))
	// all: [[0 5 1 3] [6 11 7 9] [12 17 13 15]]

	fmt.Println(r.FindAllString("peach punch pinch", 2)) // non-negative integer as second argument for these functions will limit number of matches
	// [peach punch]

	fmt.Println(r.Match([]byte("peach"))) // Use instead of MatchString with byte keyword
	// true

	r = regexp.MustCompile("p([a-z]+)ch") // MustCompile panics instead of returning an error, which makes it safer to use for global variables
	fmt.Println("regexp:", r)
	// regexp: p([a-z]+)ch

	fmt.Println(r.ReplaceAllString("a peach", "<fruit>")) // ReplaceAllString replaces matches
	// a <fruit>

	in := []byte("a peach")
	out := r.ReplaceAllFunc(in, bytes.ToUpper)
	fmt.Println(string(out))
	// a PEACH
}
