package task

import (
	"strings"
	"unicode"
)

func Atbash(s string) string {
	var res strings.Builder
	var count int

	for _, r := range strings.ToLower(s) {
		switch {
		case unicode.IsLetter(r):
			r = 'z' - (r - 'a')
		case unicode.IsDigit(r):
			r = r
		default:
			continue
		}

		if count > 0 && count%5 == 0 {
			res.WriteRune(' ')
		}

		res.WriteRune(r)
		count++
	}

	return res.String()
}
