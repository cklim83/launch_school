=begin

Multiplicative Average

Write a method that takes an Array of integers as input, multiplies all the
numbers together, divides the result by the number of entries in the Array,
and then prints the result rounded to 3 decimal places. Assume the array is
non-empty.

Examples:

show_multiplicative_average([3, 5])                # => The result is 7.500
show_multiplicative_average([6])                   # => The result is 6.000
show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667
=end

=begin
Problem
- input: an array of integers
- output: a float of 3 decimals equaling the average of the multiplicative total.

Examples
- see above
- requirements:
  - input array is non-empty, at least 1 element
  - elements of array are all integers (e.g. they can be negative)

Data Structure
- input: array of integers
- output: float of 3 integers
- intermediary: a float

Algorithm
1. Assign result to arr.reduce(&:*) / arr.size.to_f
2. Format result to 3 decimal for printing
=end

def show_multiplicative_average(arr)
  result = arr.reduce(&:*) / arr.size.to_f # given arr will not be empty
  puts format("%.3f", result)
end

show_multiplicative_average([3, 5])                # => The result is 7.500
show_multiplicative_average([6])                   # => The result is 6.000
show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667


=begin
Solution

def show_multiplicative_average(numbers)
  product = 1.to_f
  numbers.each { |number| product *= number }
  average = product / numbers.size
  puts "The result is #{format('%.3f', average)}"
end

Discussion

We could use Enumerable#inject to compute the product, but for simplicity,
we use #each instead. Once we have the desired product, we calculate the
multiplicative average and format it with three decimal places.

Further Exploration

What happens if you omit the call to #to_f on the first line of our method?
=end

=begin
TO REVIEW
- #format and how to use for common purposes
  - decimal places, leading 0 etc.
=end