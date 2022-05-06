=begin

Find Missing Numbers

Write a method that takes a sorted array of integers as an argument, and
returns an array that includes all of the missing integers (in order)
between the first and last elements of the argument.

Examples:

missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
missing([1, 2, 3, 4]) == []
missing([1, 5]) == [2, 3, 4]
missing([6]) == []

=end

=begin
Problem
- input: an array of integers sorted in ascending order
- output: a new array containing integers between the 1st and last element of input that
  are missing from the input array
  
Examples
- Assume input array already sorted in ascending orders
- integers can be negative
- return empty array if no integers are missing
- return array does not include 1st and last elements
- if input array only have less than 2 elements, return empty array
- Edge cases: First and last element same number, return empty array

Data Structures
- input: array of sorted integers
- output: new array of integers
- intermediary: new array to store the output elements

Algorithm
1. Set result to empty array
2. Return result unless size of input array >= 2
3. Set variables first_element and last_element to corresponding elements of input array
4. Iterate from first_element + 1 upto but excluding last element.
   - append to result if input_array includes number
5. return result
=end

# def missing(array)
#   result = []
#   return result unless array.size >= 2
  
#   first_element = array.first
#   last_element = array.last
#   (first_element + 1).upto(last_element - 1) { |num| result << num unless array.include?(num) }
  
#   result
# end


def missing(array)
  result = []
  array.each_cons(2) do |first, second|
    result.concat(((first + 1)..(second - 1)).to_a)
  end
  result
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []


=begin
Solution

def missing(array)
  result = []
  array.each_cons(2) do |first, second|
    result.concat(((first + 1)..(second - 1)).to_a)
  end
  result
end

Discussion

This problem boils down to finding the missing integers between each pair of
numbers in the original array. So, in the first example, we need all the
integers between -3 and -2, then between -2 and 1, and finally, between
1 and 5.

Enumerable#each_cons is extremely handy when you need to iterate through
consecutive, overlapping sequences. (Enumerable#each_slice, by contrast,
iterates through consecutive, non-overlapping sequences.) Given the
argument n, it takes every n consecutive elements from the subject
collection, and iterates through each sequence of n consecutive items.

We use each_cons here for just such an operation, taking 2-number
sequences from array. The block simply generates the list of numbers
between each pair of numbers, and appends them to the result array.

Further Exploration

Can you find other ways to solve this problem? What methods might
prove useful? Can you find a way to solve this without using a
method that requires a block?
=end


=begin
TO REVIEW
- Array#each_cons(n) to iterate through consecutive n tuples in an array

https://docs.ruby-lang.org/en/master/Enumerable.html#method-i-each_cons
a = []
(1..5).each_cons(3) {|element| a.push(element) }
a # => [[1, 2, 3], [2, 3, 4], [3, 4, 5]]

=end