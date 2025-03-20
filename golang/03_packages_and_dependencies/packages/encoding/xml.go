package main

import (
	"encoding/xml"
	"fmt"
)

// Define a struct 'Plant' to represent the XML structure with custom tags for XML encoding
type Plant struct {
	XMLName xml.Name `xml:"plant"`   // This specifies the XML element name for the struct
	Id      int      `xml:"id,attr"` // This maps the 'Id' field to an XML attribute
	Name    string   `xml:"name"`    // The 'Name' field will be a child element named 'name'
	Origin  []string `xml:"origin"`  // The 'Origin' field will map to multiple 'origin' child elements
}

// Define a custom String method for the Plant struct to format its output
func (p Plant) String() string {
	return fmt.Sprintf("Plant id=%v, name=%v, origin=%v",
		p.Id, p.Name, p.Origin)
}

func xml_function() {
	// Create a new Plant instance and assign values to its fields
	coffee := &Plant{Id: 27, Name: "Coffee"}
	coffee.Origin = []string{"Ethiopia", "Brazil"} // Assign multiple origin values

	// Marshal the Plant struct into XML format with indentation
	out, _ := xml.MarshalIndent(coffee, " ", "  ")
	fmt.Println(string(out)) // Output the formatted XML representation

	// Print the XML header along with the XML content
	fmt.Println(xml.Header + string(out))

	// Unmarshal the XML back into a Plant struct and check for errors
	var p Plant
	if err := xml.Unmarshal(out, &p); err != nil {
		panic(err)
	}
	fmt.Println(p) // Print the unmarshaled Plant struct (uses the custom String method)

	// Create another Plant instance for 'Tomato' and assign its origin
	tomato := &Plant{Id: 81, Name: "Tomato"}
	tomato.Origin = []string{"Mexico", "California"}

	// Define a nested struct 'Nesting' with nested Plant elements
	type Nesting struct {
		XMLName xml.Name `xml:"nesting"`            // XML root element is <nesting>
		Plants  []*Plant `xml:"parent>child>plant"` // Nested structure <parent><child><plant>
	}

	// Create a new instance of Nesting and assign the plants
	nesting := &Nesting{}
	nesting.Plants = []*Plant{coffee, tomato} // Add both the 'coffee' and 'tomato' plants

	// Marshal the nested struct into XML with indentation
	out, _ = xml.MarshalIndent(nesting, " ", "  ")
	fmt.Println(string(out)) // Output the nested XML structure

}
