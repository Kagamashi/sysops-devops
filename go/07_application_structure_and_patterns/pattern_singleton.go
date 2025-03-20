package main
import (
    "fmt"
    "sync"
)

/*
Singleton Pattern ensures only one instance of a struct exists.

Useful for:
- database connections
- logging systems
- configuration settings

✅ Thread-safe using sync.Once
✅ Ensures a single instance
*/

type Logger struct{}

var instance *Logger
var once sync.Once

func GetLogger() *Logger {
    once.Do(func() {
        instance = &Logger{}
    })
    return instance
}

func (l *Logger) Log(msg string) {
    fmt.Println(msg)
}

func singleton_pattern() {
    logger1 := GetLogger()
    logger2 := GetLogger()

    logger1.Log("Hello, Singleton!")

    fmt.Println(logger1 == logger2) // true, same instance
}
