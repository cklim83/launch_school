=begin

Zipper

The Array#zip method takes two arrays, and combines them into a single
array in which each element is a two-element array where the first element
is a value from one array, and the second element is a value from the
second array, in order. For example:

[1, 2, 3].zip([4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

Write your own version of zip that does the same type of operation. It
should take two Arrays as arguments, and return a new Array (the original
Arrays should not be changed). Do not use the built-in Array#zip method.
You may assume that both input arrays have the same number of elements.

Example:

zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
=end


def zip(arr_1, arr_2)
  result = []
  arr_1.each_with_index do |value, index|
    result << [value, arr_2[index]]
  end
  
  result
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]


=begin
Solution

def zip(array1, array2)
  result = []
  index = 0
  length = array1.length
  while index < length
    result << [array1[index], array2[index]]
    index += 1
  end
  result
end

Discussion

In ruby, the hardest part of dealing with two arrays simultaneously is
determining how to iterate through those arrays. Almost all of the Array
and Enumerable methods only work on one array at a time. Often, the
easiest approach is to simply use a loop and two indexes, one that
indexes the first array, and one that indexes the second. Fortunately,
in this exercise, we have two arrays of equal size, and each time we
access the same index, so we can reduce those two indexes to just one.

Once you've settled on the approach, writing the code itself can be easy;
this is one such case. All we need to do is set up our result array,
initialize the index, iterate, then return the result.

The iteration part of this process is where everything of true importance
happens. For this problem, we iterate N times, where N is the number of
elements in each of our two arrays. Then, during each iteration, we append
the appropriate elements, as a two element Array, to our result array, and
increment the index.

This can be simplified somewhat by recognizing that this loop is pretty
much what Array#each_with_index does, so we use that:

def zipper(array1, array2)
  result = []
  array1.each_with_index do |element, index|
    result << [element, array2[index]]
  end
  result
end

or, even more succintly,

def zipper(array1, array2)
  array1.each_with_index.with_object([]) do |(element, index), result|
    result << [element, array2[index]]
  end
end
=end

=begin
TO REVIEW
- We can stitch Array#each_with_index with #with_object with the syntax
    array1.each_with_index.with_object([]) do |(element, index), result|
=end