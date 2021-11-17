=begin

Sum or Product of Consecutive Integers

Write a program that asks the user to enter an integer greater than 0,
then asks if the user wants to determine the sum or product of all numbers
between 1 and the entered integer.

Examples:

>> Please enter an integer greater than 0:
5
>> Enter 's' to compute the sum, 'p' to compute the product.
s
The sum of the integers between 1 and 5 is 15.


>> Please enter an integer greater than 0:
6
>> Enter 's' to compute the sum, 'p' to compute the product.
p
The product of the integers between 1 and 6 is 720.

=end

def running_sum(number)
  (1..number).reduce(:+) # need parentheses for range else we will encounter undefined method reduce for integer. 
                         # Why is ampersand optional here but needed in puts 1.upto(99).select(&:odd?) in easy_2:06_odd_numbers?
end

def running_product(number)
  (1..number).inject(:*) # need parentheses for range else we will encounter undefined method reduce for integer
end

puts ">> Please enter an integer greater than 0:"
number = gets.chomp.to_i
puts ">> Enter 's' to compute the sum, 'p' to compute the product."
operation = gets.chomp.downcase

case operation
when 's' 
  puts "The sum of the integers between 1 and #{number} is #{running_sum(number)}"
when 'p' 
  puts "The product of the integers between 1 and #{number} is #{running_product(number)}"
end


=begin

Solution

def compute_sum(number)
  total = 0
  1.upto(number) { |value| total += value }
  total
end

def compute_product(number)
  total = 1
  1.upto(number) { |value| total *= value }
  total
end

puts ">> Please enter an integer greater than 0"
number = gets.chomp.to_i

puts ">> Enter 's' to compute the sum, 'p' to compute the product."
operation = gets.chomp

if operation == 's'
  sum = compute_sum(number)
  puts "The sum of the integers between 1 and #{number} is #{sum}."
elsif operation == 'p'
  product = compute_product(number)
  puts "The product of the integers between 1 and #{number} is #{product}."
else
  puts "Oops. Unknown operation."
end

Discussion

For brevity and simplicity, our solution doesn't try too hard to validate the
user input. Your own solution probably should try to validate input and issue
error messages as needed.

This solution first obtains the integer and operation to be performed from the
user, then we perform the requested operation using one of two methods:
compute_sum adds the numbers together, while compute_product multiplies them.
Once we have the result, we just print it.

Further Exploration

The compute_sum and compute_product methods are simple and should be familiar.
A more rubyish way of computing sums and products is with the Enumerable#inject
method. #inject is a very useful method, but if you've never used it before,
it can be difficult to understand.

Take some time to read the documentation for #inject. (Note that all Enumerable
methods can be used on Array.) Try to explain how it works to yourself.

Try to use #inject in your solution to this problem.


TO REVIEW:
- Enumerable#reduce or its alias Enumerable#inject
- When is ampersand needed in syntactic sugar form?
e.g.
1.upto(99).select(&:odd?)
(1..number).reduce(:+)

https://docs.ruby-lang.org/en/2.6.0/Enumerable.html#method-i-reduce

reduce(initial, sym) → obj
reduce(sym) → obj
reduce(initial) { |memo, obj| block } → obj
reduce { |memo, obj| block } → obj

Combines all elements of enum by applying a binary operation, specified
by a block or a symbol that names a method or operator.

The inject and reduce methods are aliases. There is no performance benefit 
to either.

If you specify a block, then for each element in enum the block is passed
an accumulator value (memo) and the element. If you specify a symbol
instead, then each element in the collection will be passed to the named
method of memo. In either case, the result becomes the new value for memo.
At the end of the iteration, the final value of memo is the return value
for the method.

If you do not explicitly specify an initial value for memo, then the
first element of collection is used as the initial value of memo.

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

=end

