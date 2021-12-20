=begin

Halvsies

Write a method that takes an Array as an argument, and returns two Arrays
(as a pair of nested Arrays) that contain the first half and second half
of the original Array, respectively. If the original array contains an odd
number of elements, the middle element should be placed in the first half
Array.

Examples:

halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
halvsies([5]) == [[5], []]
halvsies([]) == [[], []]
=end

=begin
Problem
- input: an array of elements
- output: Nested array. First inner array contain first half of elements,
          second inner array containing remaing half. If original array
          has odd number of elements, middle element belongs to the first 
          inner array

Examples
- see above
- other requirements:
  - elements in innner array follows orders in input array
  - inner arrays can be empty
  - Assuming elements can be any object type
  
Data Structure:
- input: array of elements
- output: Nested array of elements
- intermediary: probably array

Algorithm
1. Set first_half_length = ((arr.size / 2.0).round 
2. first_half = arr[0, first_half_length] # Array#slice[start_index, length]
3. second_half = arr[first_half_length, arr.size - first_half_length] 
4. return [first_half, second_half]
=end

def halvsies(arr)
  first_halve_length = (arr.size / 2.0).round
  first_halve = arr[0, first_halve_length]
  second_halve = arr[first_halve_length, arr.size - first_halve_length]
  [first_halve, second_halve]
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]


=begin
Solution

def halvsies(array)
  middle = (array.size / 2.0).ceil
  first_half = array.slice(0, middle)
  second_half = array.slice(middle, array.size - middle)
  [first_half, second_half]
end

Discussion

Our task is to split an array into two pieces, a first and second half. We
first get the middle, which is more exactly the size of the first half, by
dividing the original array's size by two. If the original array is odd in
size, then the call to ceil will account for that, making the first half
larger than the second by one.

To create both halves, the Array#slice method is used. Here slice takes two
arguments: the first one is the starting index and the second one is the
length of the slice. For the second half, we can use our middle value as the
starting index and specify a length that includes any remaining elements left
in the original array after we removed the first half.

Finally, our halvsies array is created by specifying our two halves as the
sole elements of a new array.

Further Exploration

Can you explain why our solution divides array.size by 2.0 instead of just 2?

My answer:
We need to divide by 2.0 instead of 2 to prevent truncation due to integer
division. 5/2 returns 2 while 5/2.0 returns 2.5 when rounded equals 3 elements.
=end


=begin
TO REVIEW
- Array#slice(start_index, length) aka Array[start_index, length]
- middle = (size / 2.0).ceil (divide by 2.0 instead of 2 and take ceiling so that first half 
                             has 1 more element in the even original array has odd number of elements)
- first_half = array.slice(0, middle)
- second_half = array.slice(middle, array.size - middle)
  - start index of second half is middle since first half indices run from 0 to middle - 1 for middle number of items
  - length of second half is total length - length of first_half 
- slice returns a new array/object.
=end