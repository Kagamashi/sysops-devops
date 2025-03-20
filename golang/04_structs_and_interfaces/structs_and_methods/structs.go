package main
import "fmt"

/*
Structs are collections of fields (variables) gruped together under a single type

- Fields are accessed using dot notation
	p.Name
- Fields are automatically initialized to their zero values
- Structs can have embedded (anonymous) fields to enable composition
- Pointers (*Person) can be used to avoid copying the entire struct during function calls or modifications
*/

// type alias
type Alias = OriginalType
type myInt = int

type person struct { // this person struct type has name and age fields
	name string
	age  int
}

func newPerson(name string) *person { //newPerson constructs a new person struct with given name
	p := person{name: name} // Go is a garbage collected language; we can safely return a pointer to a local variable - it will only be cleaned up by the garbage collector when there are no active references to it
	p.age = 42
	return &p // returns a pointer to person struct
}

func structs() {
	fmt.Println(person{"Bob", 20}) // this syntax creates a new struct
	// {Bob 20}

	fmt.Println(person{name: "Alice", age: 30}) // we can name the fields when initializing a struct
	// {Alice 30}

	fmt.Println(person{name: "Fred"}) // omitted fields will be zero-valued
	// {Fred 0}

	fmt.Println(&person{name: "Ann", age: 40}) // an & prefix yields a pointer to the struct
	// &{Ann 40}

	fmt.Println(newPerson("Jon")) // it's idiomatic to encapsulate new struct creation in constructor functions
	// &{Jon 42}

	s := person{name: "Sean", age: 50} // access struct fields with a dot
	fmt.Println(s.name)
	// Sean

	sp := &s // we can also use dots with struct pointers - the pointers are automatically dereferenced
	fmt.Println(sp.age)
	// 50

	sp.age = 51 // struct are mutable
	fmt.Println(sp.age)
	// 51

	dog := struct { // if a struct type is only used for a single value, we don't have to give it a name
		name   string // commonly used for table-driven tests
		isGood bool
	}{
		"Rex",
		true,
	}
	fmt.Println(dog)
	// {Rex true}
}
