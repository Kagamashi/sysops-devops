package task

func Reverse(input string) string {
    runes := []rune(input)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

// inneficient string concatenation
// func Reverse(input string) string {
//     runes := []rune(input)
// 	out := ""
    
//     for i := len(runes)-1; i >= 0; i-- {
//         out += string(runes[i])
//     }

//     return out
// }

// inneficient prepending
// func Reverse(input string) string {
// 	var out string
// 	for _, c := range input {
// 		out = fmt.Sprintf("%c%s", c, out)
// 	}
// 	return out
// }

