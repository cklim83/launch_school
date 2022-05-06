=begin

Count Items

Write a method that takes an array as an argument, and a block that returns
true or false depending on the value of the array element passed to it. The
method should return a count of the number of times the block returns true.

You may not use Array#count or Enumerable#count in your solution.

Examples:

count([1,2,3,4,5]) { |value| value.odd? } == 3
count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
count([1,2,3,4,5]) { |value| true } == 5
count([1,2,3,4,5]) { |value| false } == 0
count([]) { |value| value.even? } == 0
count(%w(Four score and seven)) { |value| value.size == 5 } == 2
=end

def count(collection)
  collection.each.reduce(0) do |sum, element| 
    yield(element) ? sum + 1 : sum
  end
end


p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } # == 2


=begin
Solution

def count(array)
  total = 0
  array.each { |value| total += 1 if yield value }
  total
end

Discussion

Our solution works by iterating over the values in array, incrementing
a counter by 1 each time the block returns true when yielded the current
value.

Further Exploration

Write a version of the count method that meets the conditions of this
exercise, but also does not use each, loop, while, or until.
=end


=begin
TO REVIEW
- #reduce will use the first element as the accumulator i.e. sum in my code example if 
  initial value is not given
- When this happens, the last test case will fail since we will attempt to increment string by 1.


def count(collection)
  collection.each.reduce do |sum, element| 
    yield(element) ? sum + 1 : sum
  end
end

p count(%w(Four score and seven)) { |value| value.size == 5 }

Traceback (most recent call last):
        6: from 10_count_items.rb:33:in `<main>'
        5: from 10_count_items.rb:22:in `count'
        4: from 10_count_items.rb:22:in `reduce'
        3: from 10_count_items.rb:22:in `each'
        2: from 10_count_items.rb:22:in `each'
        1: from 10_count_items.rb:23:in `block in count'
10_count_items.rb:23:in `+': no implicit conversion of Integer into String (TypeError)
=end