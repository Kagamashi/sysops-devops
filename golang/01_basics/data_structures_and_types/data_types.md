## Basic Data Types
| Type       | Description                          | Example |
|------------|--------------------------------------|---------|
| `bool`     | Boolean type, `true` or `false`     | `var flag bool = true` |
| `string`   | Sequence of characters              | `var name string = "GoLang"` |
| `int`      | Signed integer (platform-dependent) | `var age int = 25` |
| `int8`     | 8-bit signed integer                | `var x int8 = -128` |
| `int16`    | 16-bit signed integer               | `var y int16 = 32767` |
| `int32`    | 32-bit signed integer               | `var z int32 = 2147483647` |
| `int64`    | 64-bit signed integer               | `var big int64 = 9223372036854775807` |
| `uint`     | Unsigned integer (platform-dependent) | `var u uint = 42` |
| `uint8`    | 8-bit unsigned integer (alias: byte) | `var b byte = 255` |
| `uint16`   | 16-bit unsigned integer             | `var u16 uint16 = 65535` |
| `uint32`   | 32-bit unsigned integer             | `var u32 uint32 = 4294967295` |
| `uint64`   | 64-bit unsigned integer             | `var u64 uint64 = 18446744073709551615` |
| `float32`  | 32-bit floating-point number        | `var f float32 = 3.14` |
| `float64`  | 64-bit floating-point number        | `var g float64 = 2.71828` |
| `complex64` | Complex number with float32 real & imaginary parts | `var c complex64 = 1 + 2i` |
| `complex128` | Complex number with float64 real & imaginary parts | `var d complex128 = 3.14 + 2.71i` |

## Composite Data Types
| Type       | Description                          | Example |
|------------|--------------------------------------|---------|
| `array`    | Fixed-size collection of elements   | `var arr [3]int = [3]int{1, 2, 3}` |
| `slice`    | Dynamic-size array                  | `var slc []int = []int{1, 2, 3}` |
| `map`      | Key-value store                     | `var m map[string]int = map[string]int{"a": 1, "b": 2}` |
| `struct`   | Collection of fields                | `type Person struct { Name string; Age int }` |

## Reference Types
| Type       | Description                          | Example |
|------------|--------------------------------------|---------|
| `pointer`  | Stores the address of a variable    | `var p *int = &age` |
| `interface` | Defines a set of method signatures | `type Shape interface { Area() float64 }` |
| `function` | Functions can be assigned to variables | `var f func(int) int = someFunction` |

## Type Aliases
| Type       | Description                          | Example |
|------------|--------------------------------------|---------|
| `byte`     | Alias for `uint8`                   | `var b byte = 255` |
| `rune`     | Alias for `int32` (Unicode character) | `var r rune = 'A'` |
