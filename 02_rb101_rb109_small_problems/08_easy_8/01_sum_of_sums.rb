=begin

Sum of Sums

Write a method that takes an Array of numbers and then returns the sum of the
sums of each leading subsequence for that Array. You may assume that the Array
always contains at least one number.

Examples:

sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
sum_of_sums([4]) == 4
sum_of_sums([1, 2, 3, 4, 5]) == 35
=end

=begin
Problem
- input: array of numbers
- output: sum of each leading subsequence sum

Examples
- see above
- requirements:
  - generate all leading subsequence and take their sum
    3, 5, 2 -> [3], [3,5], [3,5,2], note: [3, 2], [5, 2] are not leading subsequences
  - edge case: the array have no numbers (not possible)

Data Structure
- input: array of numbers
- output: number
- intermdiary: array of subsequences

Algorithm
1. Set arr_sub = []
2. Iterate through each element, with index
  1. subsequence = arr.slice[0, index+1]
  2. arr_sub << subsequence
3. Flatten arr_sub and take the sum
4. Return the sum
=end

def sum_of_sums(arr)
  subsequences = []
  arr.each_with_index do |num, index|
    subsequences << arr.slice(0, index + 1)
  end
  
  subsequences.flatten.sum
end


p sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
p sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
p sum_of_sums([4]) == 4
p sum_of_sums([1, 2, 3, 4, 5]) == 35


=begin
Solution

Solution 1

def sum_of_sums(numbers)
  sum_total = 0
  accumulator = 0

  numbers.each do |num|
    accumulator += num
    sum_total += accumulator
  end

  sum_total
end

Solution 2

def sum_of_sums(numbers)
  sum_total = 0
  1.upto(numbers.size) do |count|
    sum_total += numbers.slice(0, count).reduce(:+)
  end
  sum_total
end

Discussion

This problem is straightforward once you realize that you have to keep track
of two different values. One is a running total that we'll call accumulator.
It progressively sums up the elements of the array. The other is the total
sum and it should be the value returned by our method. How do we compute this
sum_total? We need to iterate over the array: on each iteration we update the
accumulator and add it to the sum_total. This is what we do in our first
solution.

Our second solution takes a different approach. Once again, we start by
initializing a variable for the total sum. Then we decide to sum up subsets
of our numbers array and add each of those sums to the sum_total variable.

1.upto(numbers.size) is used to generate the correct size for each subset
of our numbers array. We use number.slice(0, count) to get that subset, and
then reduce(:+) is used on the current subset to add up all its elements.
Once we have computed the final sum(one that contains all numbers in our
array), and added that to our total sum, then we are finished.

Can you see how these two solutions model the problem slightly differently?
Which model did you use in your own solution?
=end

=begin
TO REVIEW
- Array#slice
- meaning of leading substrings
=end