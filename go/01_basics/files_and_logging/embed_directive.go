package main
import (
	"embed"
)

/*
embed package allows embedding static files (HTML, CSS, JSON) into a Go binary at compile time, useful for bundling assets within applications

- Use //go:embed directive to specify file(s) to embed
- Declare a variable of type string, []byte, embed.FS to hold the embedded content
- Allows bundling resources directly into the application binary, simplifying deployment and reducing external dependencies
*/

//-go:embed folder/single_file.txt
var fileString string // embed directives accept paths relative to the directory containing Go source file
// this directive embeds the contents of the file into the string variable immediately following it

//-go:embed folder/single_file.txt
var fileByte []byte // embed the contents of the file into []byte

//-go:embed folder/single_file.txt
//-go:embed folder/*.hash
var folder embed.FS // Embed multiple files/folders with wildcards - this uses a variable of embed.FS type which implements simple virtual file system

func embed_directive() {

	print(fileString)
	print(string(fileByte)) // Prints out contents of single_file.txt

	content1, _ := folder.ReadFile("folder/file1.hash")
	print(string(content1)) // Retrieve some files from embedded folder

	content2, _ := folder.ReadFile("folder/file2.hash")
	print(string(content2))

	/*
		> mkdir -p folder
		> echo "hello go" > folder/single_file.txt
		> echo "123" > folder/file1.hash
		> echo "456" > folder/file2.hash
		> go run embed_directive.go
		hello go
		hello go
		123
		456
	*/

}
