=begin


Sum of Digits

Write a method that takes one argument, a positive integer, and returns
the sum of its digits.

Examples:

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45

The tests above should print true.

For a challenge, try writing this without any basic looping constructs
(while, until, loop, and each).

=end

=begin
Problem
- input: A positive integer
- output: Positive integer which is the sum of the component digits of the input

Examples
- See above

Data Structure
- Input: Integer
- Output: Integer
- Intermediary: Possibly an array of the component digits

Algorithm
- Convert input integer to string equivalent
- Split to array containing individual characters
- Convert each element to integer and sum them up

=end


def sum(number)
  # The argument pass to reduce/inject serve as the inital value of the first block argument
  # which serves as an accumulator, passed during each iteration to elements of the calling collection
  # If no argument is passed, the inital value of sum is the first element and the first block
  # iteration will become array[0] (a string) + array[1].to_i raising an TypeError, '+' Implicit 
  # conversion of integer to string. Hence we provide 0 as argument to avoid the error
  number.to_s.chars.reduce(0) do |sum, num_str| 
    sum + num_str.to_i
  end
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45


=begin

Solution

Solution 1

def sum(number)
  sum = 0
  str_digits = number.to_s.chars

  str_digits.each do |str_digit|
    sum += str_digit.to_i
  end

  sum
end

Solution 2

def sum(number)
  number.to_s.chars.map(&:to_i).reduce(:+)
end

Discussion

This exercise proves to be tricky in a couple of ways. First, if you tried to
split the number while it was an integer you probably got an error. The key
here is to convert it to a string, then split it, like this:

23.to_s.chars # => ["2", "3"]

To remember that we are dealing with strings, we assign this array to a
variable named str_digits. We then iterate over our array and, on each
iteration, increment the sum by the given digit converted back to an integer.

What would happen if we forgot to convert the string digits back to integers?
We would get a TypeError telling us that we can't coerce a string into an 
integer. We would be trying to add a string like '2' to our initial value of 0,
which is not allowed.

Let's look at the second solution. If you did the last exercise, you may think
of using #reduce to sum the numbers in the array, like this:

def sum(number)
  number.to_s.chars.reduce(:+)
end

If you tried this, however, you probably got unexpected results. #reduce worked,
but instead of adding integers, it was adding strings, which isn't what you want.
Again, the array of strings needs to be converted to an array of integers. We can
do this using #map and Ruby's shorthand syntax:

["2", "3"].map(&:to_i) # => [2, 3]

If that looks confusing, just remember that it's the same as this:

["2", "3"].map { |element| element.to_i } # => [2, 3]

It's possible to invoke all of these methods in one statement due to the return
values of each method. All four of the methods used in the solution return the
object we need to continue chaining methods. The following code shows the return
value of each method:

23.to_s        # => "23"
  .chars       # => ["2", "3"]
  .map(&:to_i) # => [2, 3]
  .reduce(:+)  # => 5

This makes for very compact code, but maybe less readable than the first solution.
What do you think?


TO REVIEW: 

['1', '2'].map(&:to_i) is syntatic sugar and equivalent to ['1', '2'].map { |str| str.to_i }


https://docs.ruby-lang.org/en/2.6.0/Enumerable.html#method-i-reduce

reduce(initial, sym) → obj
reduce(sym) → obj
reduce(initial) { |memo, obj| block } → obj
reduce { |memo, obj| block } → obj

Combines all elements of enum by applying a binary operation,
specified by a block or a symbol that names a method or operator.

The inject and reduce methods are aliases. There is no performance
benefit to either.

If you specify a block, then for each element in enum the block is passed
an accumulator value (memo) and the element. If you specify a symbol instead,
then each element in the collection will be passed to the named method of memo.
In either case, the result becomes the new value for memo. At the end of the
iteration, the final value of memo is the return value for the method.

If you do not explicitly specify an initial value for memo, then the first
element of collection is used as the initial value of memo.

# Sum some numbers
(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
(5..10).inject { |sum, n| sum + n }            #=> 45

=end



