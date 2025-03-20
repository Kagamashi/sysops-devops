package main

import (
	"encoding/json"
	"fmt"
	"os"
)

// Define a struct for a JSON response with two fields: Page and Fruits
type response1 struct {
	Page   int
	Fruits []string
}

// Define another struct for JSON response, but this time with struct tags for custom JSON keys
type response2 struct {
	Page   int      `json:"page"`   // The field will be encoded as "page" in JSON
	Fruits []string `json:"fruits"` // The field will be encoded as "fruits" in JSON
}

func json_function() {

	// Marshal a boolean value into JSON and print it
	bolB, _ := json.Marshal(true)
	fmt.Println(string(bolB)) // Output: true

	// Marshal an integer into JSON and print it
	intB, _ := json.Marshal(1)
	fmt.Println(string(intB)) // Output: 1

	// Marshal a float value into JSON and print it
	fltB, _ := json.Marshal(2.34)
	fmt.Println(string(fltB)) // Output: 2.34

	// Marshal a string into JSON and print it
	strB, _ := json.Marshal("gopher")
	fmt.Println(string(strB)) // Output: "gopher"

	// Marshal a slice (array) of strings into JSON and print it
	slcD := []string{"apple", "peach", "pear"}
	slcB, _ := json.Marshal(slcD)
	fmt.Println(string(slcB)) // Output: ["apple","peach","pear"]

	// Marshal a map into JSON and print it
	mapD := map[string]int{"apple": 5, "lettuce": 7}
	mapB, _ := json.Marshal(mapD)
	fmt.Println(string(mapB)) // Output: {"apple":5,"lettuce":7}

	// Marshal a custom struct (response1) into JSON and print it
	res1D := &response1{
		Page:   1,
		Fruits: []string{"apple", "peach", "pear"},
	}
	res1B, _ := json.Marshal(res1D)
	fmt.Println(string(res1B)) // Output: {"Page":1,"Fruits":["apple","peach","pear"]}

	// Marshal another custom struct (response2) with JSON tags into JSON and print it
	res2D := &response2{
		Page:   1,
		Fruits: []string{"apple", "peach", "pear"},
	}
	res2B, _ := json.Marshal(res2D)
	fmt.Println(string(res2B)) // Output: {"page":1,"fruits":["apple","peach","pear"]}

	// Unmarshal (parse) a JSON string into a map of string to interface{}
	byt := []byte(`{"num":6.13,"strs":["a","b"]}`)
	var dat map[string]interface{} // A generic map for JSON objects

	if err := json.Unmarshal(byt, &dat); err != nil {
		panic(err)
	}
	fmt.Println(dat) // Output: map[num:6.13 strs:[a b]]

	// Access the "num" field and assert it as a float64
	num := dat["num"].(float64)
	fmt.Println(num) // Output: 6.13

	// Access the "strs" field (array), then access the first element and assert it as a string
	strs := dat["strs"].([]interface{}) // Convert to slice of interfaces
	str1 := strs[0].(string)            // Assert the first element as string
	fmt.Println(str1)                   // Output: a

	// Unmarshal a JSON string directly into a custom struct (response2)
	str := `{"page": 1, "fruits": ["apple", "peach"]}`
	res := response2{}
	json.Unmarshal([]byte(str), &res)
	fmt.Println(res)           // Output: {1 [apple peach]}
	fmt.Println(res.Fruits[0]) // Output: apple

	// Create a JSON encoder and output a map directly to the console
	enc := json.NewEncoder(os.Stdout)
	d := map[string]int{"apple": 5, "lettuce": 7}
	enc.Encode(d)
	// Output (to console): {"apple":5,"lettuce":7}

}
