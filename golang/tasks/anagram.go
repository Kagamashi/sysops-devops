package task

import "strings"

// Detect returns a slice of strings from 'candidates' that are anagrams of 'subject'.
func Detect(subject string, candidates []string) []string {
    var result []string
	subject = strings.ToLower(subject)
    
    // Check each candidate to see if it is an anagram of 'subject'
    for _, candidate := range candidates {
        candidateLower := strings.ToLower(candidate)
        
        if len(subject) != len(candidate) || subject == candidateLower {
            continue
        }

        if isAnagram(subject, candidateLower) {
            result = append(result, candidate)
        }
    }	
        
	return result
}

// isAnagram checks if two lowercase strings 'a' and 'b' are anagrams of each other.
func isAnagram(a, b string) bool {
    subjectCount := letterCount(a)
	candidateCount := letterCount(b)
    
    // Compare the frequency of each rune in candidateCount to subjectCount
    for r, count := range candidateCount {
        if subjectCount[r] != count {
            return false
        }
    }
    
    return len(candidateCount) == len(subjectCount)
}

// letterCount returns a map of rune frequencies for the given string 's'.
func letterCount(s string) map[rune]int {
    count := make(map[rune]int)

    for _, r := range s {
        count[r]++
    }

    return count
}