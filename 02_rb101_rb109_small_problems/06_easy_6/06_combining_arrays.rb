=begin

Combining Arrays

Write a method that takes two Arrays as arguments, and returns an Array that
contains all of the values from the argument Arrays. There should be no
duplication of values in the returned Array, even if there are duplicates in
the original Arrays.

Example

merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]
=end

=begin
Problem
- input: two arrays
- output: one array containing unique elements from both input arrays

Examples
- see above
- requirements:
  - elements ordered following first input array, then second
  - no duplicates in result
  - assume new array to be returned
  - assume input arrays not mutated
  - assume elements can be any objects

Data Structure
- input: two arrays
- output: one new array

Algorithm
1. Concatenate two arrays and call uniq
=end

def merge(list_1, list_2)
  (list_1 + list_2).uniq
end

p merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]


=begin
Solution

def merge(array_1, array_2)
  array_1 | array_2
end

Discussion

In this exercise we utilize the Ruby method Array#|. This is a method that
gives the set union of two arrays, so the result contains no duplicates. It
works perfectly for our merge method. The union part of this method means
that we get back all the elements that both array_1 and array_2 might
contain, but without duplicates.

Further Exploration

How did you go about solving this one? Using this method for set union is
convenient, but what if we didn't have it? There are certainly a few other
ways to go about solving this exercise.
=end

=begin
TO REVIEW
- Array#| method that performs union and remove duplicates while preserving
elements order.
=end