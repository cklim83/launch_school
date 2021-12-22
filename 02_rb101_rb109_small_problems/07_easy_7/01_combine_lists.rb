=begin

Combine Two Lists

Write a method that combines two Arrays passed in as arguments, and returns
a new Array that contains all elements from both Array arguments, with the
elements taken in alternation.

You may assume that both input Arrays are non-empty, and that they have the
same number of elements.

Example:

interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']
=end

=begin
Problem
- input: two non-empty arrays with same number of elements
- output: a new array, with elements taken in alternative

Examples
- see above
- other requirements
  - input arrays are non-empty
  - input arrays have same number of elements
  - elements can be any object
  - elements in new array are taken in alternative from input arrays, starting with the 
    array in the first argument
  - input arrays not mutated

Data Structure:
- input: two arrays
- output: a new array

Algorithm
1. set current index = 0, combined_arr = []
2. while current_index < arr_1.size
  a. combined_arr.push(arr_1[current_index])
  b. combined_arr.push(arr_2[current_index])
  c. increment current_index
3. combined_arr

Alternative:
- zip two arrays so that the elements in the same index of each array group in pair,
- then maybe we can flatten to get the result
=end

def interleave(arr_1, arr_2)
  current_index = 0
  combined_arr = []
  while current_index < arr_1.size
    combined_arr.push(arr_1[current_index])
    combined_arr.push(arr_2[current_index])
    current_index += 1
  end
  
  combined_arr
end

def interleave2(arr_1, arr_2)
 arr_1.zip(arr_2).flatten
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']
p interleave2([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']


=begin
Solution

def interleave(array1, array2)
  result = []
  array1.each_with_index do |element, index|
    result << element << array2[index]
  end
  result
end

Discussion

In our solution, we use #each_with_index to get values and index numbers
for array1, then use the index number to access the corresponding element
in array2.

Further Exploration

Take a few minutes to read about Array#zip. #zip doesn't do the same thing
as interleave, but it is very close, and more flexible. In fact, interleave
can be implemented in terms of zip and one other method from the Array class.
See if you can rewrite interleave to use zip.

=end

=begin
TO REVIEW
- result << a << b means a is push in first followed by b
- Array#zip 
  - The caller array determines the number of pairs assuming the caller and arguments are different in length
  a = [ 4, 5, 6 ]
  b = [ 7, 8, 9 ]
  [1, 2, 3].zip(a, b)   #=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]] # all 3 arrays same length
  [1, 2].zip(a, b)      #=> [[1, 4, 7], [2, 5, 8]] # caller is shorter
  a.zip([1, 2], [8])    #=> [[4, 1, 8], [5, 2, nil], [6, nil, nil]] # caller is longer
=end
