=begin

Tri-Angles

A triangle is classified as follows:

    right One angle of the triangle is a right angle (90 degrees)
    acute All 3 angles of the triangle are less than 90 degrees
    obtuse One angle is greater than 90 degrees.

To be a valid triangle, the sum of the angles must be exactly 180 degrees,
and all angles must be greater than 0: if either of these conditions is not
satisfied, the triangle is invalid.

Write a method that takes the 3 angles of a triangle as arguments, and
returns a symbol :right, :acute, :obtuse, or :invalid depending on whether
the triangle is a right, acute, obtuse, or invalid triangle.

You may assume integer valued angles so you don't have to worry about
floating point errors. You may also assume that the arguments are specified
in degrees.

Examples:

triangle(60, 70, 50) == :acute
triangle(30, 90, 60) == :right
triangle(120, 50, 10) == :obtuse
triangle(0, 90, 90) == :invalid
triangle(50, 50, 50) == :invalid
=end

=begin
Problem
- input: 3 integers representing angles of triangle
- ouput: one of 4 symbols

Examples
- requirements
  - triangle(60, 70, 50) == :acute
    - all angles > 0, sum of angles == 180, largest angle < 90
  - triangle(30, 90, 60) == :right
    - all angles > 0, sum of angles == 180, largest angle == 90
  - triangle(120, 50, 10) == :obtuse
    - all angles > 0, sum of angles == 180, largest angle > 90
  - triangle(0, 90, 90) == :invalid
    - one angles <= 0
  - triangle(50, 50, 50) == :invalid
    - all angles > 0, sum of angles != 180
  - all integers, no floating point errors
  
Data Structure
- input: 3 integers
- output: symbol
- intermediary: array

Algorithm
- set method input as angles array
- sort angles in place from smallest to biggest
- return :invalid if any angle is <= 0
- return :invalid if angles.sum !=180
- if largest angle > 90 return :obtuse
- elsif largest angle == 90 return :right
- else return :acute
=end

def triangle(*angles)
  angles.sort!
  return :invalid if angles.any? { |angle| angle <= 0 }
  return :invalid if angles.sum != 180
  
  case 
  when angles.max > 90 then :obtuse
  when angles.max == 90 then :right
  else :acute
  end
end


p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid


=begin
TO REVIEW
- Case statement

  Below is wrong! Use case without a value
  
  case angles.max
  when > 90 then :obtuse
  when 90 then :right
  else :acute
  end
=end