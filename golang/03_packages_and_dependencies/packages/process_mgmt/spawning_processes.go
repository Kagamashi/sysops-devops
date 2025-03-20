package main

import (
	"fmt"
	"io"
	"os/exec"
)

/* SPAWNING PROCESSES
Use exec.Command to start external programs from a Go program.

- os/exec package allows you to spawn (create) and manage external processes from a Go program
- Common functions:
exec.Command(name string, arg ...string) - creates new Cmd structure to execute the specified program
cmd.Run() - runs command and waits for it to complete
cmd.Start() - starts command but doesn't wait for it to complete (asynchronous execution)
cmd.Output() - runs command and returns its output
*/

func spawning_processes() {

	dateCmd := exec.Command("date") // exec.Command helper creates an object to represent external process

	dateOut, err := dateCmd.Output() // Output method runs the command, waits for it to finish and collects its standard output
	if err != nil {                  // If there are no errors, dateOut will hold bytes with the date info
		panic(err)
	}
	fmt.Println("> date")
	fmt.Println(string(dateOut))

	_, err = exec.Command("date", "-x").Output() // Output and other methods of Command will return *exec.Error if there was a problem executing the command (wrong path)
	if err != nil {                              // and *exec.ExitError if the command ran but exited with non-zero return code
		switch e := err.(type) {
		case *exec.Error:
			fmt.Println("failed executing:", err)
		case *exec.ExitError:
			fmt.Println("command exit rc =", e.ExitCode())
		default:
			panic(err)
		}
	}

	grepCmd := exec.Command("grep", "hello") // Case where we pipe data to external process on its stdin and collect the results from its stdout

	grepIn, _ := grepCmd.StdinPipe() // Grab input/output pipes
	grepOut, _ := grepCmd.StdoutPipe()
	grepCmd.Start()                                  // Start the process
	grepIn.Write([]byte("hello grep\ngoodbye grep")) // Write input to the process
	grepIn.Close()
	grepBytes, _ := io.ReadAll(grepOut) // Read resulting output
	grepCmd.Wait()                      // Wait for the process to exit

	fmt.Println("> grep hello") // We collected only StdoutPipe results, but we could also collect StderrPipe exactly the same way
	fmt.Println(string(grepBytes))

	lsCmd := exec.Command("bash", "-c", "ls -a -l -h") // When spawning commands we need to provide an explicitly delineated command and argument array
	lsOut, err := lsCmd.Output()
	if err != nil {
		panic(err)
	}
	fmt.Println("> ls -a -l -h")
	fmt.Println(string(lsOut))

	/*
		$ go run spawning_processes.go
		> date
		Mon Sep 16 19:41:15 CEST 2024

		command exit rc = 1
		> grep hello
		hello grep

		> ls -a -l -h
		total 32
		drwxr-xr-x   6 u767835  ENT\Domain Users   192B Sep 16 19:39 .
		drwxr-xr-x  23 u767835  ENT\Domain Users   736B Sep 14 22:24 ..
		-rw-r--r--   1 u767835  ENT\Domain Users   876B Sep 16 19:36 exec_processes.go
		-rw-r--r--   1 u767835  ENT\Domain Users   567B Sep 16 19:36 exit.go
		-rw-r--r--   1 u767835  ENT\Domain Users   969B Sep 16 19:36 signals.go
		-rw-r--r--   1 u767835  ENT\Domain Users   2.4K Sep 16 19:41 spawning_processes.go
	*/

}
