package task

import "strings"

func pangram(input string) bool {
    s := strings.ToLower(input)

    for c := 'a'; c <= 'z'; c++ {
        if !strings.ContainsRune(s, c) {
            return false
        }
    }

    return true
}
