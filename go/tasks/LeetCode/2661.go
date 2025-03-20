// #2661
// First Completely Painted Row or Column

package leetcode

func firstCompleteIndex(arr []int, mat [][]int) int {
	m, n := len(mat), len(mat[0])

	// Map each number to its position in mat
	position := make(map[int][2]int) // number from mat; row and column
	for i := 0; i < m; i++ {
			for j := 0; j < n; j++ {
					position[mat[i][j]] = [2]int{i, j}
			}
	}

	// Arrays to track how many cells are painted in each row and column
	rowCount := make([]int, m)
	colCount := make([]int, n)

	for i, num := range arr {
			pos := position[num]
			row, col := pos[0], pos[1]

			rowCount[row]++
			colCount[col]++

			if rowCount[row] == n || colCount[col] == m {
					return i
			}
	}

	return -1
}