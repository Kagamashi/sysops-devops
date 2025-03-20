// #1368
// MINIMUM COST TO MAKE AT LEAST ONE VALID PATH IN A GRID 

package main

import (
	"container/heap"
	"fmt"
)

// Define directions for movement: right, left, down, up
var directions = [][]int{
	{0, 1},  // Right
	{0, -1}, // Left
	{1, 0},  // Down
	{-1, 0}, // Up
}

// Point represents a cell in the grid with coordinates (x, y) and the accumulated cost to reach it
type Point struct {
	x, y, cost int
}

// MinHeap is a priority queue used to get the next cell with the minimum cost
type MinHeap []Point

// Len returns the number of elements in the heap
func (h MinHeap) Len() int { return len(h) }

// Less compares two elements in the heap to maintain the min-heap property
func (h MinHeap) Less(i, j int) bool { return h[i].cost < h[j].cost }

// Swap exchanges two elements in the heap
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

// Push adds an element to the heap
func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Point))
}

// Pop removes and returns the smallest element from the heap
func (h *MinHeap) Pop() interface{} {
	n := len(*h)
	x := (*h)[n-1]
	*h = (*h)[:n-1]
	return x
}

// minCost calculates the minimum cost to make at least one valid path in the grid
func minCost(grid [][]int) int {
	m, n := len(grid), len(grid[0]) // Dimensions of the grid

	// Visited array to keep track of processed cells
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	// Min-Heap initialized with the starting point (0, 0) and cost 0
	minHeap := &MinHeap{{0, 0, 0}}
	heap.Init(minHeap)

	for minHeap.Len() > 0 {
		// Get the cell with the minimum cost
		curr := heap.Pop(minHeap).(Point)
		x, y, cost := curr.x, curr.y, curr.cost

		// Skip this cell if it has already been visited
		if visited[x][y] {
			continue
		}
		visited[x][y] = true

		// If the bottom-right corner is reached, return the cost
		if x == m-1 && y == n-1 {
			return cost
		}

		// Process all four possible directions
		for dir, d := range directions {
			nx, ny := x+d[0], y+d[1] // Calculate the coordinates of the next cell
			if nx >= 0 && nx < m && ny >= 0 && ny < n {
				newCost := cost
				// Increment the cost if the direction does not match the grid value
				if grid[x][y] != dir+1 {
					newCost++
				}
				// Push the next cell into the heap with the calculated cost
				heap.Push(minHeap, Point{nx, ny, newCost})
			}
		}
	}

	return -1 // Return -1 if no valid path exists (should not occur in valid inputs)
}

func main() {
	grid1 := [][]int{
		{1, 1, 1, 1},
		{2, 2, 2, 2},
		{1, 1, 1, 1},
		{2, 2, 2, 2},
	}
	fmt.Println(minCost(grid1)) // Output: 3

	grid2 := [][]int{
		{1, 1, 3},
		{3, 2, 2},
		{1, 1, 4},
	}
	fmt.Println(minCost(grid2)) // Output: 0

	grid3 := [][]int{
		{1, 2},
		{4, 3},
	}
	fmt.Println(minCost(grid3)) // Output: 1
}
