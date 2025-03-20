package main

import (
	"os"
	"os/exec"
	"syscall"
)

/* EXECING PROCESSES
Use syscall.Exec to replace the current process with a new one.

'Execing' refers to replacing the current process with a new one.
In Go, this is done using syscall.Exec, effectively stopping the current program and running another program in its place.

- syscall.Exec(argv0 string, argv []string, envv []string) - replaces current proces with a new one.
argv0 is the program name; argv is the list of arguments; envv is the environment variables
- Once syscall.Exec is called, current process terminates and is replaced by the new one
*/

func exec_processes() {

	binary, lookErr := exec.LookPath("ls") // Go requires an absolute path to the binary we want to execute so we'll use exec.LookPath to find it
	if lookErr != nil {
		panic(lookErr)
	}

	args := []string{"ls", "-a", "-l", "-h"} // Exec requires arguments in slice form (as opposed to one big string) - we give 'ls' a few common arguments

	env := os.Environ() // Exec also needs a set of environment variables to use - here we just provide our current environment

	execErr := syscall.Exec(binary, args, env) // syscall.Exec call - if this call is successful the execution of our process wil lend here and be replaced by the '/bin/ls -a -l -h' process
	if execErr != nil {
		panic(execErr)
	}

	/*
			$ go run exec_processes.go
		total 32
		drwxr-xr-x   6 u767835  ENT\Domain Users   192B Sep 16 19:41 .
		drwxr-xr-x  23 u767835  ENT\Domain Users   736B Sep 14 22:24 ..
		-rw-r--r--   1 u767835  ENT\Domain Users   1.5K Sep 16 19:55 exec_processes.go
		-rw-r--r--   1 u767835  ENT\Domain Users   567B Sep 16 19:36 exit.go
		-rw-r--r--   1 u767835  ENT\Domain Users   969B Sep 16 19:36 signals.go
		-rw-r--r--   1 u767835  ENT\Domain Users   3.0K Sep 16 19:55 spawning_processes.go
	*/

}
