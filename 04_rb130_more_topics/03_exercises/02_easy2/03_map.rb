=begin

map

Lets return to implementing existing core ruby methods to learn about blocks.

The Enumerable#map method iterates over the members of a collection, using the
associated block to perform some sort of operation on each collection member.
The returned values from the block are then built up into an Array that is
then returned to the caller. Note in particular that every time #map yields
to the block, it obtains just one value. That value may be a complex value
- it may even be another collection - but it is nevertheless just one value.
Thus, #map returns an Array that has the same number of elements that the
original collection had.

Write a method called map that behaves similarly for Arrays. It should take
an Array as an argument, and a block. It should return a new Array that
contains the return values produced by the block for each element of the
original Array.

If the Array is empty, map should return an empty Array, regardless of how
the block is defined.

Your method may use #each, #each_with_object, #each_with_index, #inject,
loop, for, while, or until to iterate through the Array passed in as an
argument, but must not use any other methods that iterate through an
Array or any other collection.

Examples:

map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
map([]) { |value| true } == []
map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

=end


=begin
Problem
- input: an array and block
- output: a new array containing the return values of the block

Examples
- input array can have any object type i.e. integer, string etc
- input arrau can be empty
- block should take one parameter
- block return value can be complex

Data Structures
- input: array, block
- output: new array

Algorithm
1. Set result = []
2. Iterate through input array, yield each element to block
3. Append return value to result
4. Return result
=end


def map(collection)
  result = []
  collection.each { |element| result << yield(element) }
  
  result
end

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]


=begin
Solution

def map(array)
  result = []
  array.each { |item| result << yield(item) }
  result
end

Discussion

Our solution simply iterates through our array, and appends the return value
of yield(item) to our result Array.

Further Exploration

Does your solution work with other collections like Hashes or Sets?
=end