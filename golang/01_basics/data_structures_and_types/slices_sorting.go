package main

import (
	"fmt"
	"slices"
	"cmp"
)

/* SORTING
Sorting is used to arrange data in specific order (ascending or descending).
- Go provides sort package for sorting built-in types
- Simplifies sorting of common data types without requiring custom logic
*/

func sorting() {

	strs := []string{"c", "a", "b"}
	slices.Sort(strs)
	fmt.Println("Strings:", strs)
	// Strings: [a b c]

	ints := []int{7, 2, 4}
	slices.Sort(ints)
	fmt.Println("Ints:   ", ints)
	// Ints: [2 4 7]

	s := slices.IsSorted(ints) // Check if slice is already sorted
	fmt.Println("Sorted: ", s)
	// Sorted: true

}


/*
Sometimes we want to sort collection by something other than its natural order.
For example sort strings by their length instead of alphabetically.
 */

func sorting_by_functions() {
	fruits := []string{"peach", "banana", "kiwi"}

	lenCmp := func(a, b string) int {  // Comparison function for string lengths
		return cmp.Compare(len(a), len(b))
	}

	slices.SortFunc(fruits, lenCmp)  // Now we call slices.SortFunc with custom comporison function to sort fruits slice by name length
	fmt.Println(fruits)
	// [kiwi peach banana]

	type Person struct {
		name string
		age  int
	}

	people := []Person{
		Person{name: "Jax", age: 37},
		Person{name: "TJ", age: 25},
		Person{name: "Alex", age: 72},
	}

	slices.SortFunc(people, // Sort people by age
		func(a, b Person) int {
			return cmp.Compare(a.age, b.age)
		})
	fmt.Println(people)
	// [{TJ 25} {Jax 37} {Alex 72}]

}
