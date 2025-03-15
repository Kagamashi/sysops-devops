'''
[MINIMUM TIME VISITING ALL POINTS]

On 2D plane, there are n points with integer coordinates points[i] = [x1, y1].
Return the minimum time in seconds to visit all the points in the order given by points.

Rules for moving:
- In 1 second you can either:
    - move vertically by one unit
    - move horizontally by one unit
    - move diagonally sqrt(2) units 
- You have to visit the points in the same order as they appear in the array
- You are allowed to pass through points that appear later in the order, but these do not count as visits

Solution: If next node is +10x and -5y away it's going to take exactly 10 steps because you can only move 1x at a time and the difference in y is made up by diagonal moves
during the process of overcoming the difference in x.
- Move diagonally as much as possible reducing unnecessary moves.
- Stack-based processing (pop) - processes points from last to first

Time O(N)
Space O(1)

[!] Coding shouldn't be the difficult part. Distance between two points is maximum difference of one coord.

Example:
    Input: points = [[1,1],[3,4],[-1,0]]
    Output: 7
'''

class Solution:
    def minTimeToVisitAllPoints(self, points: List[List[int]]) -> int:      # type: ignore
        res = 0 # length in seconds
        for i in range(len(points) - 1):
            x1, y1 = points[i] 
            x2, y2 = points[i+1]
            res += max(abs(x2 - x1), abs(y2 - y1))
        return res


        # pop() solution:
        res = 0 # length in seconds
        x1, y1 = points.pop() #[-1,0]
        # pop() removes the last element

        while points:
            x2, y2 = points.pop() #[3,4]
            res += max(abs(y2-y1), abs(x2-x1)) # distance between two points is maximum difference of one coord
            x1, y1 = x2, y2
        
        return res
