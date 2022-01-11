=begin

Triangle Sides

A triangle is classified as follows:

    equilateral All 3 sides are of equal length
    isosceles 2 sides are of equal length, while the 3rd is different
    scalene All 3 sides are of different length

To be a valid triangle, the sum of the lengths of the two shortest sides
must be greater than the length of the longest side, and all sides must
have lengths greater than 0: if either of these conditions is not satisfied,
the triangle is invalid.

Write a method that takes the lengths of the 3 sides of a triangle as
arguments, and returns a symbol :equilateral, :isosceles, :scalene, or
:invalid depending on whether the triangle is equilateral, isosceles,
scalene, or invalid.

Examples:

triangle(3, 3, 3) == :equilateral
triangle(3, 3, 1.5) == :isosceles
triangle(3, 4, 5) == :scalene
triangle(0, 3, 3) == :invalid
triangle(3, 1, 1) == :invalid
=end

=begin
Problem
- input: take 3 numeric arguments
- ouput: a symbol :equilateral or :isosceles or :scalene or :invalid

Examples
- requirements
  - non-zero lengths, sum of 2 smaller lengths are greater than the 3rd length and all 3 lengths are equal to return :equilateral
  - non-zero lengths, sum of 2 smaller lengths are greater than the third and 2 lengths are equal to return :isosceles
  - non-zero lengths, all different values and sum of 2 shortest values greater than the largest to return :scalene
  - presence of zero length to return :invalid
  - non-zero lengths, sum of 2 smaller lengths though equal are not greater than 3rd length to return :invalid
  - Assume no floating pointing precision issues

Data Structure
- input: 3 numbers
- output: one of 4 symbols
- intermediary: sorted input length (ascending order)

Algorithm
- check to ensure ALL sides are >0, else return :invalid
- check to ensure sum of 2 smaller lengths are > than the largest length, else return :invalid
  - If number of unique values = 3, return :scalene
  - If number of unique values = 2, return :isosceles
  - If number of unique values = 1, return :equilateral
=end

def triangle(*sides)
  result = nil
  sides.sort! # sort in ascending order
  
  return :invalid if sides.any? { |length| length <= 0 }
  return :invalid if sides[2] >= sides[1] + sides[0]
  
  case sides.uniq.size
  when 1 then result = :equilateral
  when 2 then result = :isosceles
  else result = :scalene
  end
  
  result
end


p triangle(3, 3, 3) == :equilateral
p triangle(3, 3, 1.5) == :isosceles
p triangle(3, 4, 5) == :scalene
p triangle(0, 3, 3) == :invalid
p triangle(3, 1, 1) == :invalid


=begin
TO REVIEW
- Array#uniq return the unique elements in the array, not their size
- Enumerable#any?
- Array#sort and sort_by
- Using *arg to receive multiple arguments as a list

- We do not need to have a varible result, since case is the last statement and will return the value directly

  def triangle(*sides)
  sides.sort! # sort in ascending order
  
  return :invalid if sides.any? { |length| length <= 0 }
  return :invalid if sides[2] >= sides[1] + sides[0]
  
  case sides.uniq.size
  when 1 then :equilateral
  when 2 then :isosceles
  else :scalene
  end
end
=end