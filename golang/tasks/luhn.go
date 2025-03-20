package task

import (
	"strings"
	"strconv"
)

func Valid(id string) bool {
	id = strings.ReplaceAll(id, " ", "")

	if len(id) <= 1 {
		return false
	}

	isSecondDigit := len(id) % 2 == 0
	sum := 0

	for _, r := range id {
		v, err := strconv.Atoi(string(r))

		if err != nil {
			return false
		}

		if isSecondDigit {
			v *= 2
			
			if v > 9 {
				v -= 9
			}
		}

		sum += v
		isSecondDigit = !isSecondDigit
	}
	
	return sum % 10 == 0
}

//

// func Valid_2(id string) bool {

// 	var n, d, i, m int 

// 	for i = len(s) - 1; i >= 0; i-- {
// 		c := s[i]

// 		switch {
// 		case == ' ':
// 			continue
// 		case c >= '0' && c <= '9':
// 			m = int(c - '0')
// 			if d % 2 == 1 {
// 				m <<= 1
// 			}
// 			if m > 9 {
// 				m -= 9
// 			}
// 			n += m
// 			d++
// 		default:
// 			return false
// 		}
// 	}

// 	return d > 1 && n % 10 == 0
// }
