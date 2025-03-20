package main
import (
	"fmt"
	"iter"
	"slices"
)

/*
Iterators allow us to range over pretty much anything.
package "iter"
https://go.dev/blog/range-functions
*/

type List[T any] struct { // generic singly linked list implementation that can store elements of any type T
	head, tail *element[T]  // two pointers pointing to the first and last element of the list
}

type element[T any] struct { // represents a node in the linked list
	next *element[T]
	val  T
}

func (lst *List[T]) Push(v T) { //adds a new element v to the end of the linked list
	if lst.tail == nil {
		lst.head = &element[T]{val: v}
		lst.tail = lst.head
	} else {
		lst.tail.next = &element[T]{val: v}
		lst.tail = lst.tail.next
	}
}

func (lst *List[T]) All() iter.Seq[T] { // All() method returns an iterator (a sequence generator iter.Seq[T]) which allows the caller to iterate over all elements in the list
	return func(yield func(T) bool) {

		for e := lst.head; e != nil; e = e.next {
			if !yield(e.val) { // yield(e.val) is a callback that "yields" the value of the current element e.val to the caller
				return //if yield returns false, iteration stops early
			} // yield is an arbitraty name
		}
	}
}

/*
iteration doesn't require an underlying data structure and doesn't even have to be infinite.
*/
func genFib() iter.Seq[int] { //generator function that produces an infinite sequence of Fibonacci numbers
	return func(yield func(int) bool) {
		a, b := 1, 1

		for {
			if !yield(a) { // keeps running as long as yield is returning true
				return
			}
			a, b = b, a+b
		}
	}
}

func range_over_iterators() {
	lst := List[int]{} //creating and populating linked list
	lst.Push(10)
	lst.Push(13)
	lst.Push(23)

	for e := range lst.All() { // uses iterator returned by lst.All() to iterate over and print each element in the list
		fmt.Println(e)
	}

	all := slices.Collect(lst.All()) // collects all elements from the iterator into a slice
	fmt.Println("all:", all)
	// all: [10 13 23]

	for n := range genFib() { // once the loop hit break or an early return, the yield function passed to the iterator will return false

		if n >= 10 {
			break
		}
		fmt.Println(n)
	}
}
