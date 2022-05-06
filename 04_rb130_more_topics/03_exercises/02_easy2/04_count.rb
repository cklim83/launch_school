=begin

count

NOTE: This exercise was originally a duplicate from the previous exercise set.
We have modified it slightly, but some of the posted solutions still reflect
the original wording.

The Enumerable#count method iterates over the members of a collection, passing
each element to the associated block. It then returns the number of elements
for which the block returns a truthy value.

Write a method called count that behaves similarly for an arbitrarily long
list of arguments. It should take 0 or more arguments and a block, and then
return the total number of arguments for which the block returns true.

If the argument list is empty, count should return 0.

Your method may use #each, #each_with_object, #each_with_index, #inject,
loop, for, while, or until to iterate through the Array passed in as an
argument, but must not use any other methods that iterate through an Array
or any other collection.

Examples:

count(1, 3, 6) { |value| value.odd? } == 2
count(1, 3, 6) { |value| value.even? } == 1
count(1, 3, 6) { |value| value > 6 } == 0
count(1, 3, 6) { |value| true } == 3
count() { |value| true } == 0
count(1, 3, 6) { |value| value - 6 } == 3
=end

def count(*numbers)
  truthy_count = 0
  numbers.each { |item| truthy_count += 1 if yield(item) }
  truthy_count
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3


=begin
Solution

def count(*arguments)
  total = 0
  arguments.each { |item| total += 1 if yield(item) }
  total
end

Discussion

Our solution simply iterates through the arguments, incrementing
our total each time yield(item) returns a truthy value.

Note that we use *arguments in the method definition; this lets us
treat the list of arguments as an Array of values, which means the
rest of our count method does not need to change (other than the
change in variable name).
=end


=begin
TO REVIEW
- * operator for method parameter allows us to accept variable number of arguments
  and store them in a list.
=end