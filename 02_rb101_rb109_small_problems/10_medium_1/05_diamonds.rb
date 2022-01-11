=begin
Diamonds!

Write a method that displays a 4-pointed diamond in an n x n grid, where
n is an odd integer that is supplied as an argument to the method. You may
assume that the argument will always be an odd integer.

Examples

diamond(1)

*

diamond(3)

 *
***
 *

diamond(9)

    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
=end

=begin
Problem 
- input: n, a positive odd integer
- output: a 4 edged diamond printout, with 1, 3, .. n, .. 3, 1 count of *s 
          over n rows

Examples
- requirements
  - n is positive and odd integer
  
Data Structure
- input: integer
- output: printout
- intermediary: array of array, with each element containing the characters
                to print for each row.

Observations
- Each row has n characters, made up of stars and spaces
- Stars are always centralised with equal spaces flanking on either side
- The number of stars in the diamond follows this pattern [1, 3, 5, .., n-2, n, n- 2, .., 5, 3, 1] 
  for a total of n elements corresponding to n rows
- For each row, we have ' '*left_space_count + '*'* star_count, + ' '* right_space_count


Algorithm
1. Let row_stars be the array containing the number of stars in each row
    - row_stars should have the pattern [1, 3, 5, .., n-2, n, n- 2, .., 5, 3, 1]
    - create an array of odds numbers that count up from 1 to n, then down back to 1 containing n elements
2. Iterate through each element in row_stars,
    - half_space_count = (n - number of stars in row) / 2
    - puts ' '*half_space_count + '*'*stars_for_row + ' '*half_space_count
=end

def diamond(n)
  odd_counts_to_n = (1..n).to_a.select { |num| num.odd? }
  row_stars = odd_counts_to_n + odd_counts_to_n.reverse[1..-1]
  
  row_stars.each do |star_for_row|
    half_row_space = (n - star_for_row) / 2
    puts " "*half_row_space + "*"*star_for_row + " "*half_row_space
  end
end

diamond(1)
puts ""
diamond(3)
puts ""
diamond(5)
puts ""
diamond(11)


=begin
Solution

def print_row(grid_size, distance_from_center)
  number_of_stars = grid_size - 2 * distance_from_center
  stars = '*' * number_of_stars
  puts stars.center(grid_size)
end

def diamond(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(0) { |distance| print_row(grid_size, distance) }
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

Discussion

Our solution breaks the problem down into two smaller problems: printing a
single row of the diamond, and a method to iterate through those rows.

Iterating through the rows is most easily handled if you recognize that the
bottom part of the diamond is the mirror image of the top part, with the
center row of the diamond between these two parts. Our solution takes this
into account and iterates first from the first row to the middle row of the
diamond, and then iterates in the reverse direction from the row just below
the center to the bottom row. We use the variable distance to keep track of
how far we are from the center row, with the center row being a distance of
0 from itself.

For each iteration, we call the print_row method. print_row uses the grid
size and the distance from the center row to determine how many stars are
needed, and to center those stars within our grid.

We could have done all this in one method, but the result would have either
been pretty messy, or it would repeat itself. By breaking things down into
sub-problems, we were able to solve this problem easily.
Further Exploration

Try modifying your solution or our solution so it prints only the outline
of the diamond:

diamond(5)

  *
 * *
*   *
 * *
  *
=end

=begin
TO REVIEW
Errors made by me when trying to create row_stars = [1, 3, 5 .. n ..5, 3, 1]

  a) row_stars = (1..n).select { |num| n.odd? } + (n..1).select { |num| n.odd?}
    - the block should read num.odd? rather than n.odd? (careless mistake)
    - we cannot use range (n..1) to count down. e.g. (3..1).to_a returns [] rather than [3, 2, 1]
    - correcting the above, i got 
    
      row_stars = (1..n).select { |num| num.odd? } + (1..n).select { |num| num.odd? }.reverse
      => [1, 3 ..n, n, .., 3, 1]
  
  b) Tried to remove extra n using #delete(n), and forgot that that it will remove ALL occurence of n
     which will produce [1, 3 ..n-2, n-2, .., 3, 1] instead. Fixed it with slicing and concatenation.
      
      odd_counts_to_n = (1..n).to_a.select { |num| num.odd? }
      row_stars = odd_counts_to_n + odd_counts_to_n.reverse[1..-1]
      
      Alternative solution: using 1...n to omit n when counting down to 1
      row_stars = (1..n).select { |num| num.odd? } + (1...n).select { |num| num.odd? }.reverse
     
- Familiarise how to count down using #downto, and in increments of more than 1
- Familiarise with slice, using ranges with .. and ...
- Familiarise how to delete for strings and array, both single and multiple items.
- Familiarise with String#center to centralize text, with padding.
=end