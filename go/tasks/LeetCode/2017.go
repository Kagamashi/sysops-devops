// #2017
// Grid Game

package leetcode

func gridGame(grid [][]int) int64 {
	minResult := int64(^uint64(0) >> 1) // Maximum value of int64
	row1Sum := int64(0)
	
	// Calculate sum of top row
	for _, value := range grid[0] {
			row1Sum += int64(value)
	}

	row2Sum := int64(0)

	for i := 0; i < len(grid[0]); i++ {
			row1Sum -= int64(grid[0][i])
			if row1Sum > row2Sum {
					if row1Sum < minResult {
							minResult = row1Sum
					}
			} else {
					if row2Sum < minResult {
							minResult = row2Sum
					}
			}
			row2Sum += int64(grid[1][i])
	}

	return minResult
}