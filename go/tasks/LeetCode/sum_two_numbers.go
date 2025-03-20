package leetcode

type ListNode struct {
	Val  int
	Next *ListNode
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	dummyHead := &ListNode{} // Simplifies edge cases
	current := dummyHead
	carry := 0

	for l1 != nil || l2 != nil || carry != 0 {
			sum := carry

			if l1 != nil {
					sum += l1.Val
					l1 = l1.Next
			}

			if l2 != nil {
					sum += l2.Val
					l2 = l2.Next
			}

			carry = sum / 10  // Update carry for next iteration

			current.Next = &ListNode{Val: sum % 10}
			current = current.Next
	}

	return dummyHead.Next
}
