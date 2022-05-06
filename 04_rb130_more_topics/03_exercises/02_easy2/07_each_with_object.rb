=begin

each_with_object

The Enumerable#each_with_object method iterates over the members of a
collection, passing each element and an arbitrary object (usually a
collection) to the associated block. The value returned by the block is
not used. The object that is passed to the block is defined as an argument
to each_with_object; with each iteration, this object may be updated by
the block. When iteration is complete, the final value of the object is
returned.

Write a method called each_with_object that behaves similarly for Arrays.
It should take an Array and an object of some sort as an argument, and a
block. It should yield each element and the object to the block.
each_with_object should return the final value of the object.

If the Array is empty, each_with_object should return the original object
passed as its second argument.

Your method may use #each, #each_with_index, #inject, loop, for, while,
or until to iterate through the Array passed in as an argument, but must
not use any other methods that iterate through an Array or any other
collection.

Examples:

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
result == {}
=end


=begin
Problem
- input: an array, a collection object and a block
- output: the collection object

Examples
- collection can be array or hash
- input array can be empty

Data Structure
- input: array, collection and block
- output: modified collection object

Algorithm
1. Iterate over the array, yield each element and collection to block
2. Return collection
=end


def each_with_object(collection, object)
  collection.each { |item| yield(item, object) }
  object
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}


=begin
Solution

def each_with_object(array, object)
  array.each { |item| yield(item, object) }
  object
end

Discussion

Implementing this method is easier than it sounds. All that stuff about
the "object" makes it sound harder than it really is. In fact, all we
need to do with that object is yield it (along with the element value)
to our block for each element of the Array. At the end, we just need to
make sure we return that object.
=end


=begin
TO REVIEW
- #each_with_object, the object is passed to the block as second parameter and this method returns the object itself.
=end