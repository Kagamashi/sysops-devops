// 1. Two Sum

package leetcode

func twoSum(nums []int, target int) []int {
	mymap := make(map[int]int)

	for i, num := range nums {
			if j, ok := mymap[target-num]; ok {
					return []int{j, i}
			}
			mymap[num] = i
	}
	return nil
}
