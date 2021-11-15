=begin

Array Average

Write a method that takes one argument, an array containing integers, and
returns the average of all numbers in the array. The array will never be
empty and the numbers will always be positive integers. Your result should
also be an integer.

Examples:

puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40

The tests above should print true.

=end

=begin
Problem
- Input: An array of positive integers, never empty
- Output: An intger containing the average of the array elements
- Requirements:
  - We will perform integer division when finding average, i.e. truncation
  - No empty array edge case. No division by error edge case
  - No non-integer, non-numeric array elements

Examples
- See above

Data Structure
- Input: Array
- Output: Integer
- Intermediary: Integer

Algorithm
- Sum up the elements of input array
- Perform integer division to find the average

=end

def average(numbers)
  numbers.sum / numbers.size
end

puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40


=begin

Solution

def average(numbers)
  sum = numbers.reduce { |sum, number| sum + number }
  sum / numbers.count
end

Discussion

Two things need to be done to find the average. First, add every number
together. Second, divide the sum by the number of elements. We accomplish
the first part by using Enumerable#reduce(also known as #inject), which
combines all elements of the given array by applying a binary operation.
This operation is specified by a block or symbol. We used a block in our
solution, but we could have just as easily used a symbol, like this:

numbers.reduce(:+)

Once we have the sum, all that's left is to divide it by the number of
elements. To do that, we use #count to count the number of elements in
numbers. Then, we divide sum by the number of elements and return the
quotient.

Further Exploration

Currently, the return value of average is an Integer. When dividing numbers,
sometimes the quotient isn't a whole number, therefore, it might make more
sense to return a Float. Can you change the return value of average from an
Integer to a Float?


TO REVIEW: Enumerable#reduce/inject and Array#count methods

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
# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
(5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"


https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-count

count → int
count(obj) → int
count {|item| block} → int

Returns the number of elements.

If an argument is given, counts the number of elements which equal obj using ==.

If a block is given, counts the number of elements for which the block returns a true value.

ary = [1, 2, 4, 2]
ary.count                  #=> 4
ary.count(2)               #=> 2
ary.count {|x| x%2 == 0}   #=> 3

=end