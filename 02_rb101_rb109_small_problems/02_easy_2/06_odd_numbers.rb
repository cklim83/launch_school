=begin

Odd Numbers

Print all odd numbers from 1 to 99, inclusive, to the console, with each
number on a separate line.

=end

for i in (1..99)
  puts i if i.odd?
end


=begin
Solution

value = 1
while value <= 99
  puts value
  value += 2
end

Discussion

There are a variety of different ways to approach this problem, so 
don't be worried if your solution is significantly different.

Our solution simply takes a very basic approach of counting up from
1 to 99 by 2s, and printing each value.

Further Exploration

Repeat this exercise with a technique different from the one you just
used, and different from the solution shown above. You may want to
explore the use Integer#upto or Array#select methods, or maybe
use Integer#odd?

Other solutions

# Using .each and Modulo to Identify Off Numbers
(1..99).each {|num| puts num if num % 2 == 1 }

# Using .each and num.odd?
(1..99).each {|num| puts num if num.odd?}

# Using .select and num.odd?
(1..99).select {|num| puts num if num.odd?}  # Returns [] artifact (as puts returns nil)

# Using .upto and num.odd?
puts 1.upto(99).select(&:odd?) # Why is ampersand & required here but not needed in Enumerable#reduce/inject? 


TO REVIEW:
- Integer#upto

https://docs.ruby-lang.org/en/2.6.0/Integer.html#method-i-upto

upto(limit) {|i| block } → self
upto(limit) → an_enumerator

Iterates the given block, passing in integer values from int up to 
and including limit.

If no block is given, an Enumerator is returned instead.

5.upto(10) {|i| print i, " " }   #=> 5 6 7 8 9 10

=end