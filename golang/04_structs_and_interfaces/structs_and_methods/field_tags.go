package main
import (
	"encoding/json"
	"fmt"
)

/*
Field tags are metadata annotations added to struct fields
Used primarily for serialization/deserialization (JSON, XML, YAML)
Tags are optional but widely used in web services, APIs and data encoding

common JSON tags:
	json:"name"		| maps field to a custom JSON key
	json:"name,omitempty"	| omits field if it has a zero value("", 0, nil)
	json:"-"	| excludes field from JSON encoding/decoding
*/

// Define a struct with JSON field tags
type User struct {
	ID        int    `json:"id"`        // Maps "ID" field to "id" in JSON
	FirstName string `json:"first_name"` // Custom JSON key
	LastName  string `json:"last_name,omitempty"` // "omitempty" removes field if empty
	Password  string `json:"-"` // "-" excludes field from JSON output
}

func field_tags() {
	user := User{ID: 1, FirstName: "John", LastName: "", Password: "secret"}

	// Serialize struct to JSON
	jsonData, _ := json.Marshal(user)
	fmt.Println(string(jsonData)) // Output: {"id":1,"first_name":"John"}
}
