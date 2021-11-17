=begin

Running Totals

Write a method that takes an Array of numbers, and returns an Array
with the same number of elements, and each element has the running
total from the original Array.

Examples:

running_total([2, 5, 13]) == [2, 7, 20]
running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
running_total([3]) == [3]
running_total([]) == []

=end

=begin

Problem
- input: An array of numbers
- output: An array of numbers that are running sums of input array

Examples
- See above
- See edge case of empty array

Data Structure
- input: Array
- output: Array

Algorithm
1 - Set sum = 0, index = 0, running_sums = [] 
2 - Check index < input_array.size, break if false
3 - add input_array[index] to sum
4 - Push sum to running_sums
5 - Increment index
6 - Repeat step 2
7 - return running_sums

=end

def running_total(numbers)
  sum = 0
  running_sums = []
  numbers.each_with_object(running_sums) do |number, array|
    sum += number
    array << sum
  end
  
  running_sums
end

p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []


=begin

Solution

def running_total(array)
  sum = 0
  array.map { |value| sum += value }
end

Discussion

This solution does nothing fancy; it just walks through the array
calculating the running total while building the resulting array.
#map makes this really easy.

Further Exploration

Try solving this problem using Enumerable#each_with_object or
Enumerable#inject (note that Enumerable methods can be applied to Arrays).

=end