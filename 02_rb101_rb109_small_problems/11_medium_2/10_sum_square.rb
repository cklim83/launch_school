=begin

Sum Square - Square Sum

Write a method that computes the difference between the square of the sum
of the first n positive integers and the sum of the squares of the first
n positive integers.

Examples:

sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
sum_square_difference(10) == 2640
sum_square_difference(1) == 0
sum_square_difference(100) == 25164150
=end

=begin
Problem
- input: an integer n
- output: (sum of sequence 1..n)**2 - (1**2 + 2**2 +... +n**2)

Examples
- requirements
  - assume n is a positive number and can be as small as 1
    based on sum_square_difference(1) == 0

Data Structure
- input: positive integer
- output: integer
- intermediary: array or not needed

Algorithm
1. set sequence = (1..n).to_a,  sum_square = 0
2. Iterate through each element in sequence with a block
    sum_square += element**2
3. return (sum of sequence) ** 2 - sum_square
=end

def sum_square_difference(n)
  sequence = (1..n).to_a
  sum_of_squares = 0
  sequence.each do |num|
    sum_of_squares += num * num
  end
  
  ((sequence.sum)**2) - sum_of_squares
end


p sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150


=begin
Solution

def sum_square_difference(n)
  sum = 0
  sum_of_squares = 0

  1.upto(n) do |value|
    sum += value
    sum_of_squares += value**2
  end

  sum**2 - sum_of_squares
end

Discussion

The hardest part of this exercise is just figuring out what is meant by square
of the sum and sum of the squares. Our first example demonstrates this clearly
with a comment that shows how we arrive at the answer.

The primary solution shows all of the details of this operation; we loop
through all of the integers between 1 and n, and compute the sum and sum of
squares as we go. At the end, we subtract the sum of the squares from the
square of the sum.
=end


=begin
TO REVIEW
- how to use reduce, inject to compute sum of squares and square of sum
=end