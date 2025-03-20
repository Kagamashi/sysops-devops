package task

import (
    "math"
    "math/rand"
    "sort"
)

type Character struct {
	Strength     int
	Dexterity    int
	Constitution int
	Intelligence int
	Wisdom       int
	Charisma     int
	Hitpoints    int
}

// Modifier calculates the ability modifier for a given ability score
func Modifier(score int) int {
	return int(math.Floor(float64(score-10) / 2))
}

// Ability uses randomness to generate the score for an ability
func Ability() int {
    dice := []int{
    	rand.Intn(6) + 1,
        rand.Intn(6) + 1,
        rand.Intn(6) + 1,
        rand.Intn(6) + 1,
	}

	sort.Ints(dice)
	return dice[1] + dice[2] + dice[3]
	// return rand.Intn(15) + 3
}

// GenerateCharacter creates a new Character with random scores for abilities
func GenerateCharacter() Character {
    char := Character{
        Strength: Ability(),
        Dexterity: Ability(),
        Constitution: Ability(),
        Intelligence: Ability(),
        Wisdom: Ability(),
        Charisma: Ability(),
    }

    char.Hitpoints = Modifier(char.Constitution) + 10

    return char
}
