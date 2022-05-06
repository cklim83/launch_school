=begin

drop_while

The Enumerable#drop_while method begins by iterating over the members
of a collection, passing each element to the associated block until it
finds an element for which the block returns false or nil. It then
converts the remaining elements of the collection (including the element
that resulted in a falsey return) to an Array, and returns the result.

Write a method called drop_while that behaves similarly for Arrays. It
should take an Array as an argument, and a block. It should return all
the elements of the Array, except those elements at the beginning of the
Array that produce a truthy value when passed to the block.

If the Array is empty, or if the block returns a truthy value for every
element, drop_while should return an empty Array.

Your method may use #each, #each_with_object, #each_with_index, #inject,
loop, for, while, or until to iterate through the Array passed in as an
argument, but must not use any other methods that iterate through an
Array or any other collection.

Examples:

drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| true } == []
drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
drop_while([]) { |value| true } == []

This line in the examples is not a typo:

drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
=end

=begin
Problem
- input: an array and block
- output: a new array starting with the first element that have a falsely block return value and elements there after

Examples
- Return empty array if all elements have truthy block return value
- Input array can be empty, then return empty array

Data Structure
- input: array and block
- output: new array

Algorithm
1. Set starting_index = nil
2. Iterate with index through input array
     next if block returns truefalse
     starting_index = index
     break
3. Return new array array[starting_index..-1]
=end


def drop_while(collection)
  start_index = nil
  collection.each_with_index do |item, index|
    next if yield(item)
    start_index = index
    break
  end
  
  start_index ? collection[start_index..-1] : []
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []


=begin
Solution

def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end

Discussion

While we could use each or each_with_index, our solution employs
a simple while loop instead; while makes it obvious that we want
to stop prematurely, since we know that we may not be iterating
through the entire Array.

Once we've skipped over the elements for which the block returns
true, all we need to do is extract the remaining elements from the
Array, which we do with array[index..-1]; this slicing syntax
extracts a slice of the Array starting at index, and ending with
the final element at index -1.
=end