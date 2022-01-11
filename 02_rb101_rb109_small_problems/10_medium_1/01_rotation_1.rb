=begin

Rotation (Part 1)

Write a method that rotates an array by moving the first element to
the end of the array. The original array should not be modified.

Do not use the method Array#rotate or Array#rotate! for your implementation.

Example:

rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true
=end

=begin
Problem
- input: array of object
- output: new array with the first element shifted to the last

Examples
- Requirements
  - Inputs can be any array with at least 1 element of any type
  - First element in input array should be the last element of return array
  - input array should not be modified

Data Structures
- input: array
- output: new array

Algorithm
1. Set rotated_array = input_array.dup 
2. shift rotated_array, push return value back to rotated_array
=end


def rotate_array(arr)
  rotated_arr = arr.dup
  first_element = rotated_arr.shift
  rotated_arr.push(first_element)
  rotated_arr
end


p rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
p rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
p rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
p rotate_array(x) == [2, 3, 4, 1]   # => true
p x == [1, 2, 3, 4]                 # => true


=begin
Solution

def rotate_array(array)
  array[1..-1] + [array[0]]
end

Discussion

There are multiple ways to solve this, but we show just one.

Our solution simply slices everything out of the array except the
first element, then appends the original first element to the end.
Note that we must be careful to not mutate array.

Further Exploration

Write a method that rotates a string instead of an array. Do the
same thing for integers. You may use rotate_array from inside your
new method.
=end


=begin
TO REVIEW
- Array#shift, unshift, pop and push methods

- Using array slice and concatenation to return a new copy.
   array[1..-1] + [array[0]]
   
=end