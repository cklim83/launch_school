=begin

Seeing Stars

Write a method that displays an 8-pointed star in an nxn grid, where n is an
odd integer that is supplied as an argument to the method. The smallest such
star you need to handle is a 7x7 grid.

Examples

star(7)

*  *  *
 * * *
  ***
*******
  ***
 * * *
*  *  *

star(9)

*   *   *
 *  *  *
  * * *
   ***
*********
   ***
  * * *
 *  *  *
*   *   *
=end

=begin
Problem
- input: odd integer n, whose value is at least 7
- output: an 8-pointed stars in an n by n grid

Examples
- requirements
  - 3 stars in every row except the middle row
  - middle row has n stars
  - we have n rows
  - top half and bottom half are mirror images
  - first (and last) rows has 2 stars at either extremity and 1 in middle
  - 2 extremity stars shift inwards are we move closer to middle row
  - n >= 7

Data Structure
- input: odd integer n whose value is at least 7
- output: 8-pointed stars in n by n grid

Algorithm
1.  Set space = ' ' * n 
For rows 1.upto((n/2), 1..3
      - index of left star = i - 1
      - index of middle star = (n - 1) / 2
      - index of right star = n - i
      - The rest are all spaces
2. Middle row = n stars
3. For row n.downto(((n/2) + 2)
      - index of left star = n - i
      - index of middle star = (n - 1) / 2
      - index of right star = i - 1
=end

def row(grid_size, row_num)
    row_values = ' ' * grid_size
    row_values[row_num - 1] = '*'
    row_values[grid_size / 2] = '*'
    row_values[grid_size - row_num] = '*'
    row_values
end

def star(grid_size)
  # Upper half of star
  1.upto(grid_size / 2) do |row_num|
    puts row(grid_size, row_num)
  end
  
  # Middle row
  puts "*" * grid_size
  
  # Lower half of star
  ((grid_size / 2) + 2).upto(grid_size) do |row_num|
    puts row(grid_size, row_num)
  end
end
      
      
star(7)
puts ""
star(9)


=begin
Solution

def print_row(grid_size, distance_from_center)
  number_of_spaces = distance_from_center - 1
  spaces = ' ' * number_of_spaces
  output = Array.new(3, '*').join(spaces)
  puts output.center(grid_size)
end

def star(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(1) { |distance| print_row(grid_size, distance) }
  puts '*' * grid_size
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

Discussion

This problem is nearly identical to an earlier problem in the Medium section,
Diamonds, though the results look a bit different. The solution itself is
very similar, so should be easy to understand if you understood the previous
solution. There are two differences of note.

The first difference occurs in the main method, which we call star in our
solution. In diamond, we didn't need any special handling for the middle row
of our diamond since it fit the same pattern of the rows above and below it.
This is not the case with our star, so we have to handle the middle line
separately. Fortunately, this is easy to do.

The other difference is in print_row. Here we take a slightly different route
to constructing the output string, though in the end we do exactly the same
thing by printing the row centered within the grid size.

Further Exploration

What other patterns can you come up with that can be produced in similar ways
to the patterns of this exercise? Can you draw a reasonable looking circle?
How about a sine wave?
=end