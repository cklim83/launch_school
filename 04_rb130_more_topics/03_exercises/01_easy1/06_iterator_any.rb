=begin

Iterators: True for Any?

A great way to learn about blocks is to implement some of the core ruby
methods that use blocks using your own code. Over this exercise and the
next several exercises, we will do this for a variety of different
standard methods.

The Enumerable#any? method processes elements in a collection by passing
each element value to a block that is provided in the method call. If the
block returns a value of true for any element, then #any? returns true.
Otherwise, #any? returns false. Note in particular that #any? will stop
searching the collection the first time the block returns true.

Write a method called any? that behaves similarly for Arrays. It should
take an Array as an argument, and a block. It should return true if the
block returns true for any of the element values. Otherwise, it should
return false.

Your method should stop processing elements of the Array as soon as the
block returns true.

If the Array is empty, any? should return false, regardless of how the
block is defined.

Your method may not use any standard ruby method that is named all?,
any?, none?, or one?.

Examples:

any?([1, 3, 5, 6]) { |value| value.even? } == true
any?([1, 3, 5, 7]) { |value| value.even? } == false
any?([2, 4, 6, 8]) { |value| value.odd? } == false
any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
any?([1, 3, 5, 7]) { |value| true } == true
any?([1, 3, 5, 7]) { |value| false } == false
any?([]) { |value| true } == false
=end

=begin
Problem
- input: An array with block
- output: boolean

Examples
- input array can be numbers. Block takes 1 parameter
- The parameter may or may not be used in block
- Input array can contain 0 or more elements, of any type
- If input array is empty, do not yield block, return false
- Execution stops the moment any block return value is true, need not iterate through all elements

Data Structure
- input: array, block
- output a boolean

Algorithm
1. Return false if input array is empty
2. Iterate through each element, yield to block. Return true if block returns truthy value
3. Return false
=end

def any?(array)
  array.each do |element|
    return true if yield(element)
  end
  
  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false


=begin
Solution

def any?(collection)
  collection.each { |item| return true if yield(item) }
  false
end

Discussion

Our solution simply iterates through our collection, and returns true
the first time it encounters an item that produces a true result when
it is yielded to the block. If no such item is encountered, we return
false.

Further Exploration

Our solution uses Enumerable#each for the main loop. The advantage of
doing this is that any? will work with any Enumerable collection, including
Arrays, Hashes, Sets, and more. So, even though we only need any? to work
with Arrays, we get additional functionality for free.

Does your solution work with other collections like Hashes or Sets?
=end


=begin
CONCEPT
- #each here can be for any standard or custom collections that have implemented
  each and just for array. Enumerable module does not implement each but relies
  on the collection class to have an each implementation so that methods in
  Enumerable can use it for iteration.

- Hence the input argument should not be called array. Collection is more
  appropriate 
=end