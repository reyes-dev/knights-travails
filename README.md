# knights_travails
This program should contain a function that shows the shortest possible way to get from one square in a game board to another by outputting all squares a knight piece will stop along the way. 

# knight_moves function
The game board will have 2 dimensional coordinates, example of function invocation:
knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

# steps
1. Put together a script that creates a game board and a knight.
2. Treat all possible moves the knight could make as children in a tree. Don't allow any moves to go off the board. 
3. Decide which search algorithm is best to use for this case. 
4. Use the chosen search algorithm to find the shortest path between the starting square (node) and the ending square (node). 
5. Output what that full path looks like.

Example: 
  > knight_moves([3,3],[4,3])
  => You made it in 3 moves!  Here's your path:
    [3,3]
    [4,5]
    [2,4]
    [4,3]