package main
import "fmt"

/*
'range' keyword is used to iterate over elements in arrays, slices, maps, string and channels
*/

func range_f() {

	nums := []int{2, 3, 4} // using range to sum numbers in a slice
	sum := 0
	for _, num := range nums {
		sum += num
	}
	fmt.Println("sum:", sum)
	// sum: 9

	for i, num := range nums { // range on arrays/slices provides both the index and value for each entry
		if num == 3 {
			fmt.Println("index:", i)
			// index: 1
		}
	}

	kvs := map[string]string{"a": "apple", "b": "banana"} // range on map iterates over key/value pairs
	for k, v := range kvs {
		fmt.Printf("%s -> %s\n", k, v)
		// a -> apple
		// b -> banana
	}

	for k := range kvs { // range can also iterate over just the keys of a map
		fmt.Println("key:", k)
	}

	for i, c := range "go" { // range on strings iterates over Unicode code points
		fmt.Println(i, c) // the first value is the starting byte index of the rune and the second the rune itself
		// 0 103
		// 1 111
	}
}
