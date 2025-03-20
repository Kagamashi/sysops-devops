package main
import (
	"fmt"
	"testing"
)

/* TESTING (correctness)
testing package provides tools for writing unit tests
- test function must be named with Test prefix
- it takes pointer to testing.T as an argument
- it should not return anything
- test file names must end in _test.go
- 'go test' command runs all tests in package

Common functions:
	t.Error(args...) - reports an error but continues execution of the test
	t.Fatal(args...) - reports an error and stops execution of the test
	t.Run(name string, fn func(t *testing.T)) - subtests allow organizing related test cases

Naming conventions:
	unit test: 	TestFunctionName
	subtests:		t.Run("SubtestName")
	table test	TestFunctionName_TableDriven

Test coverage with 'go test -cover' it provides detailed coverage report
'go test -coverprofile=coverage.out'
'go tool cover -html=coverage.out'

Fails if coverage is low:
go test -coverprofile=coverage.out ./... | awk '/total:/ {if ($3 < 80.0) exit 1}'
*/

func IntMin(a, b int) int { // Typically code we're testing would in file called intutils.go and test file for it would be named intutils_test.go
	if a < b {
		return a
	}
	return b
}

func TestIntMinBasic(t *testing.T) { // Test is created by writing a function with a name beginning with Test
	ans := IntMin(2, -2)
	if ans != -2 {

		t.Errorf("IntMin(2, -2) = %d; want -2", ans) // t.Error* will report test failures but continue executing the test
	}
}

// Table-Driven Tests allows testing multiple cases efficiently in a single test function
func TestIntMinTableDriven(t *testing.T) { // Wirting tests can be repetitive, so it's idiomatic to use table-driven style where test inputs and expected outputs are listed in a table and a single loop walks over them and performs the test logic
	var tests = []struct {
		a, b int
		want int
	}{
		{0, 1, 0},
		{1, 0, 0},
		{2, -2, -2},
		{0, -1, -1},
		{-1, 0, -1},
	}

	for _, tt := range tests {

		testname := fmt.Sprintf("%d,%d", tt.a, tt.b)
		t.Run(testname, func(t *testing.T) { // t.Run enables running 'subtests', one for each table entry
			ans := IntMin(tt.a, tt.b) // These are shown separately when executing go test -v
			if ans != tt.want {
				t.Errorf("got %d, want %d", ans, tt.want)
			}
		})
	}

	/*
    > go test -v

    == RUN   TestIntMinBasic
    --- PASS: TestIntMinBasic (0.00s)
    === RUN   TestIntMinTableDriven
    === RUN   TestIntMinTableDriven/0,1
    === RUN   TestIntMinTableDriven/1,0
    === RUN   TestIntMinTableDriven/2,-2
    === RUN   TestIntMinTableDriven/0,-1
    === RUN   TestIntMinTableDriven/-1,0
    --- PASS: TestIntMinTableDriven (0.00s)
        --- PASS: TestIntMinTableDriven/0,1 (0.00s)
        --- PASS: TestIntMinTableDriven/1,0 (0.00s)
        --- PASS: TestIntMinTableDriven/2,-2 (0.00s)
        --- PASS: TestIntMinTableDriven/0,-1 (0.00s)
        --- PASS: TestIntMinTableDriven/-1,0 (0.00s)
    PASS
    ok      examples/testing-and-benchmarking    0.023s
	*/

}


// Subtests allow running multiple test cases inside a single test function - t.Run
func TestStringOperations(t *testing.T) {
	// subtest 1
	t.Run("Length", func(t *testing.T) {
		s := "hello"
		if len(s) != 5 {
			t.Errorf("Expected length 5, got %d", len(s))
		}
	})

	// subtest 2
	t.Run("Concatenation", func(t *testing.T) {
		s := "hello" + " world"
		expected := "hello world"
		if s != expected {
			t.Errorf("Expected %s, got %s", expected, s)
		}
	})
}
