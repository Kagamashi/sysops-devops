package main
import (
	"fmt"
	"maps"
)

/*
Maps are unordered collections of key-value pairs.
var m map[string]int
m := make[map[string]int]
m := map[string]int{"apple": 2, "banana": 5}

- Keys can be any comparable type (strings, integers...)
- Zero value of a map is 'nil', and it must be initialized using make or a literal before use
- Values can be retrieve using (where ok indicates if the key exists):
value, ok := m[key]
- Key-value pair can be deleted from a map
delete(m, key)
*/

func map_structure() {

	m := make(map[string]int) //to create empty map use builtin make: make(map[key-type]var-type)

	m["k1"] = 7 //set key/value pairs using typical name[key] = val syntax
	m["k2"] = 13

	fmt.Println("map:", m)
	// map: map[k1:7 k2:13]

	v1 := m["k1"] //get a value for a key with name[key]
	fmt.Println("v1:", v1)
	// v1: 7

	v3 := m["k3"] //if key doesn't exist, the zero value of value type is returned
	fmt.Println("v3:", v3)
	// v3: 0

	fmt.Println("len:", len(m)) //builtin len returns the number of key/value pairs
	// len: 2

	delete(m, "k2") //builtin delete removes key/value pairs from a map
	fmt.Println("map:", m)
	// map: map[k1:7]

	clear(m) //builtin clear removes all key/value pairs from a map
	fmt.Println("map:", m)
	// map: map[]

	_, exists := m["k2"] //optional second return value when getting a value from a map indicates if the key was present in the map
	fmt.Println("prs:", exists)
	// prs: false

	n := map[string]int{"foo": 1, "bar": 2}
	fmt.Println("map:", n)
	// map: map[bar:2 foo:1]

	n2 := map[string]int{"foo": 1, "bar": 2} //map package contains useful utilities functions for maps
	if maps.Equal(n, n2) {
		fmt.Println("n == n2")
	}

}
