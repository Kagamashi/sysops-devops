package main
import (
	"bytes"
	"fmt"
	"log"
	"os"

	"log/slog"
)

/*
Logging is essential for tracking application behavior, debugging and monitoring.

*log package* for free-form output
log.Println(args...) - logs a message with newline at the end
log.SetFlags(flag int) - configures output format of log messages
	log.Ldate - date in local time zone (YYYY/MM/DD)
	log.Ltime - time in local time zone (HH:MM)
	log.Lshortfile - adds filename and line number to the log message
	log.Llongfile - adds full path and line number
log.New
log.Fatal(args...) - logs a message and calls os.Exit(1) which terminates the program
log.Panic(args...) - logs a message and calls panic() which causes runtime panic

*log/slog* package for structured output
Log Levels: Info, Error, Debug
	slog.NewJSONHandler
	slog.New
*/

func logging() {

	log.Println("standard logger")
	// 2024/09/16 18:30:13 standard logger

	log.SetFlags(log.LstdFlags | log.Lmicroseconds) // By default standard logger has log.Ldate and log.Ltime flags set collected in log.LstdFlags
	log.Println("with micro")
	// 2024/09/16 18:30:13.305099 with micro

	log.SetFlags(log.LstdFlags | log.Lshortfile) // Emits file name and line
	log.Println("with file/line")
	// 2024/09/16 18:30:13 logging.go:38: with file/line

	mylog := log.New(os.Stdout, "my:", log.LstdFlags) // Custom logger with custom prefix to distinguish its output from other loggers
	mylog.Println("from mylog")
	// my:2024/09/16 18:30:13 from mylog

	mylog.SetPrefix("ohmy:") // We can set prefix on existing loggers with SetPrefix method
	mylog.Println("from mylog")
	// ohmy:2024/09/16 18:30:13 from mylog

	var buf bytes.Buffer // Loggers can have custom output targets, any io.Writer works
	buflog := log.New(&buf, "buf:", log.LstdFlags)
	buflog.Println("hello")                 // This call writes log output into buf
	fmt.Print("from buflog:", buf.String()) // Show output from buf in standard output
	// from buflog:buf:2024/09/16 18:30:13 hello

	jsonHandler := slog.NewJSONHandler(os.Stderr, nil) // slog package provides structured log output, here we can log in JSON format
	myslog := slog.New(jsonHandler)
	myslog.Info("hi there")
	// {"time":"2024-09-16T18:30:13.305189+02:00","level":"INFO","msg":"hi there"}

	myslog.Info("hello again", "key", "val", "age", 25)
	// {"time":"2024-09-16T18:30:13.305206+02:00","level":"INFO","msg":"hello again","key":"val","age":25}

}
