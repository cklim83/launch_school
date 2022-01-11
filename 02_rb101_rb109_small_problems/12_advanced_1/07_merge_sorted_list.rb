=begin

Merge Sorted Lists

Write a method that takes two sorted Arrays as arguments, and returns a new
Array that contains all elements from both arguments in sorted order.

You may not provide any solution that requires you to sort the result array.
You must build the result array one element at a time in the proper order.

Your solution should not mutate the input arrays.

Examples:

merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
merge([], [1, 4, 5]) == [1, 4, 5]
merge([1, 4, 5], []) == [1, 4, 5]
=end

=begin
Problem
- input: two sorted integer arrays
- output: a new merged sorted integer array

Examples
- requirements
  - inputs should not be mutated
  - a new array should be returned
  - result should be already sorted
  - result should be built element by element in proper order
  - result elements may be repeated
  - each input array may have repeated elements
  - any input arrays can be empty or of different size

Data Structure
- input: two integer arrays
- output: a new merged sorted integer array

Algorithm
- set result = [], arr_1_index = 0, arr_2_index = 0
- while arr_1_index < arr_1.size && arr_2_index < arr_2.size
  - compare value of respective at their index values
    - push the smaller value to result, 
    - increment the index of array
      whose value was pushed
  end while
- if arr_1_index < arr_1.size
    result += arr_1[arr_1_index..-1]
  elsif arr_2_index < arr_2.size
    result += arr_2[arr_2_index..-1]
- end
- return result
=end

def merge(arr_1, arr_2)
  result = []
  arr_1_index = 0
  arr_2_index = 0
  
  while (arr_1_index < arr_1.size) \
        && (arr_2_index < arr_2.size)
    if arr_1[arr_1_index] <= arr_2[arr_2_index]
      result << arr_1[arr_1_index]
      arr_1_index += 1
    else
      result << arr_2[arr_2_index]
      arr_2_index += 1
    end
  end
  
  # one of the input arrays is fully inserted to result
  if arr_1_index < arr_1.size
    result += arr_1[arr_1_index..-1]
  else
    result += arr_2[arr_2_index..-1]
  end
  
  result
end

p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]


=begin
Solution

def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

Discussion

This problem is a lot trickier than it looks, especially with the proviso
that you may not sort the result, but have to produce a sorted list. It's
made even harder by not allowing mutation.

The obvious solution is to walk through both arrays simultaneously, keeping
track of where you are in each array with appropriate indexes. We'll modify
this a tiny bit by using Array#each to iterate through the array, and use
an index to track our location in the array2.

With each iteration of array1, we copy all elements from array2 that are
less than or equal to the array1 value, incrementing our index as needed.
Note that we need to be careful to not try copying any values from array2
that aren't there. After copying these elements, we then append the
current value from array1, and start the next iteration.

When the loops are done, we may be left with 1 or more items in array2
that were not included in the results. The last step is to make sure they
are included.

We did not write this method all in one go; it took several debugging
rounds to get just the right sequence of actions. It was not easy to get
right.
=end

=begin
TO REVIEW
- Using += Array#slice to do concatenation
- Using #concat to do concatenation to modify caller inplace.
=end
