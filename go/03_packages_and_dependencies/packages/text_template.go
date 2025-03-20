package main

import (
	"os"
	"text/template"
	//"html/template"
)

/* TEXT TEMPLATES
/text/template is used for gnerating text output with dynamic data.
It allows placeholders in templated to be replaced with actual values.
{{.Field}} - prints the field value from a data structure
{{if .Condition}} - conditional logic
{{range .Slice}} - iterates over a slice

- Useful
*/

func text_templates() {

	t1 := template.New("t1")                // Creates new template object named "t1"
	t1, err := t1.Parse("Value is {{.}}\n") // Templates are a mix of static text and "actions' enclosed in {{...}} that are used for dynamic insertion of content
	if err != nil {
		panic(err)
	}

	t1 = template.Must(t1.Parse("Value: {{.}}\n")) // Using template.Must for error handling - it panics if parsing fails

	t1.Execute(os.Stdout, "some text") // Execute the template
	t1.Execute(os.Stdout, 5)
	t1.Execute(os.Stdout, []string{
		"Go",
		"Rust",
		"C++",
		"C#",
	})
	// Value: some text
	// Value: 5
	// Value: [Go Rust C++ C#]

	Create := func(name, t string) *template.Template { // Function that creates new template
		return template.Must(template.New(name).Parse(t)) // Handles errors using template.Must
	}

	t2 := Create("t2", "Name: {{.Name}}\n") // Create a template "t2" that expects a struct or map with a "Name" field

	t2.Execute(os.Stdout, struct {
		Name string
	}{"Jane Doe"})
	// Name: Jane Doe
	t2.Execute(os.Stdout, map[string]string{
		"Name": "Mickey Mouse",
	})
	// Name: Mickey Mouse

	t3 := Create("t3", // Create a template "t3" that prints yes if the provided data is non-empty
		"{{if . -}} yes {{else -}} no {{end}}\n")

	t3.Execute(os.Stdout, "not empty")
	t3.Execute(os.Stdout, "")
	// yes
	// no

	t4 := Create("t4", // Create a template "t4" that uses 'range' action to loop over a slice of strings
		"Range: {{range .}}{{.}} {{end}}\n")
	t4.Execute(os.Stdout,
		[]string{
			"Go",
			"Rust",
			"C++",
			"C#",
		})
	// Range: Go Rust C++ C#

}
