package main
import (
	"bufio"
	"fmt"
	"net"
	"net/http"
	"net/url"
	"time"
)

/* HTTP CLIENT
net/http package provides built-in HTTP client to send HTTP requests and receive responses from servers
- http.Get/http.Post - Simple GET/POST requests
- http.NewRequest - custom requests, more control over headers, methods and request bodies
- http.Client - timeouts
*/

func http_client() {

	resp, err := http.Get("https://gobyexample.com") // Issue HTTP GET request to a server
	if err != nil {                                  // http.Get is a convenient shortcut around creating http.Client object and calling it Get method (it uses http.DefaultClient object with default settings)
		panic(err)
	}
	defer resp.Body.Close()

	fmt.Println("Response status:", resp.Status) // Print the HTTP response status

	scanner := bufio.NewScanner(resp.Body) // Print the first 5 lines of the response body
	for i := 0; scanner.Scan() && i < 5; i++ {
		fmt.Println(scanner.Text())
	}

	/*
		Response status: 200 OK
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="utf-8">
				<title>Go by Example</title>
	*/

	if err := scanner.Err(); err != nil {
		panic(err)
	}
}


/* HTTP SERVER
net/http package also allows you to create HTTP servers to handle incoming HTTP requests
- http.HandleFunc - registers handlers to respond to different URL patterns
- http.ListenAndServe - starts the server on a specified port
- http.Request - to access incoming request data
- http.ResponseWriter - send responses
- encoding/json to send JSON responses
- http.Server for advanced settings: timeouts, TLS, custom middleware
*/

/*
	Handler is an object implementing http.Handler interface

Common way to write handler is by using http.HandlerFunc adapter on functions with appropriate signature
Functions serving as handlers take http.Responsewriter and http.Request as arguments
Response writer is used to fill in the HTTP response
*/
func hello(w http.ResponseWriter, req *http.Request) { // req is incoming HTTP request
	fmt.Fprintf(w, "hello\n")
}

// This handler reads all HTTP request headers and echoing them into the response body
func headers(w http.ResponseWriter, req *http.Request) { // responds to requests made to the /headers URL path

	for name, headers := range req.Header { // iterates over all headers in incoming HTTP request
		for _, h := range headers { // for each header it writes the header name and value to HTTP response
			fmt.Fprintf(w, "%v: %v\n", name, h)
		}
	}
}

func http_server() {

	http.HandleFunc("/hello", hello)     // Registering handlers on server routes using http.HandleFunc function
	http.HandleFunc("/headers", headers) // It sets up default router in net/http package and takes a function as an argument

	http.ListenAndServe(":8090", nil) // Finally we call ListenAndServe with port and a handler, nil tells it to use default router we set up with previous commands

	/*
		$ go run http_server.go & // Run server in the background
		$ curl localhost:8090/hello
		hello
	*/
}


/* URL PARSING
net/url package provides functions for parsing, constructing and manipulating URLs in Go.
It simplifies extracting components from URLs and working with query parameters.

urlParse(rawURL string) - parses raw URL string into url.URL struct which contains fields for the scheme, host, path etc..
u.Scheme, u.Host, u.Path, u.Query() - access individual components of parsed URL
url.URL.String() - converts url.URL struct back into a properly formatted URL string

https://adam.herokuapp.com/past/2010/3/30/urls_are_the_uniform_way_to_locate_resources/
*/

func url_parsing() {

	s := "postgres://user:pass@host.com:5432/path?k=v#f" // rawURL
	// scheme://authentication info@host:port/path?query params, query fragment

	u, err := url.Parse(s)
	if err != nil {
		panic(err)
	}

	fmt.Println(u.Scheme)
	// postgres

	fmt.Println(u.User) // User contains all authentication info
	// user:pass
	fmt.Println(u.User.Username())
	// user
	p, _ := u.User.Password()
	fmt.Println(p)
	// pass

	fmt.Println(u.Host) // Host contains hostname and the port
	// host.com:5432
	host, port, _ := net.SplitHostPort(u.Host)
	fmt.Println(host)
	// host.com
	fmt.Println(port)
	// 5432

	fmt.Println(u.Path) // Path and fragments after #
	// /path
	fmt.Println(u.Fragment)
	// f

	fmt.Println(u.RawQuery)
	// k=v
	m, _ := url.ParseQuery(u.RawQuery)
	fmt.Println(m)
	// map[k:[v]]
	fmt.Println(m["k"][0])
	// v
}


/* CONTEXT
HTTP servers are useful for demonstrating the usage of context.Context for controlling cancellation.
A Context carries deadlines, cancellation signals, and other request-scoped values across API boundaries and goroutines.
*/

func hello_c(w http.ResponseWriter, req *http.Request) {

	ctx := req.Context() // context.Context is created for each request by the net/http machinery and is available with the Context() method
	fmt.Println("server: hello handler started")
	defer fmt.Println("server: hello handler ended")

	select { // Wait for few seconds before sending a reply to the client
	case <-time.After(10 * time.Second): // This could simulate some work the server is doing
		fmt.Fprintf(w, "hello\n")
	case <-ctx.Done():

		err := ctx.Err() // Contexts Err() method returns an error that explains why Done() channel was closed
		fmt.Println("server:", err)
		internalError := http.StatusInternalServerError
		http.Error(w, err.Error(), internalError)
	}
}

func context() {

	http.HandleFunc("/hello", hello_c) // Register our handler on "/hello" route
	http.ListenAndServe(":8090", nil)

	/* Output:
	$ go run context.go &
	$ curl localhost:8090/hello
	server: hello handler started
	^C // Simulate client request to /hello by hitting Ctrl+C shortly after starting the server
	server: context canceled
	server: hello handler ended
	*/
}
