=begin

Bubble Sort with Blocks

In an earlier exercise, you were asked to construct a #bubble_sort!
method that used the bubble sort algorithm to sort Arrays in place.
Our solution was this:

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1] <= array[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end

The problem with this solution is that it doesn't give you any freedom
in terms of the criteria used for the sort. For example, perhaps you
want to sort the Array in reverse order from usual, or perhaps you want
to sort a list of names in a case-insensitive manner.

Your task in this assignment is to modify #bubble_sort! so it takes an
optional block that determines which of two consecutive elements will
appear first in the results.

If you still have a copy of your #bubble_sort! method, you may use that
method as the basis for this exercise. Otherwise, you can use the above
solution.

Examples:

array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]  
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
=end

=begin
Problem
- input: array to be sorted, optional block with code telling us how to sort
- output: same array sorted in place

Examples
- If block not given, sort in ascending order
- If block given, yield two arguments to block. swap only if block returns false
- first <= second, sort in ascending, second <= first sort in descending

Data Structure
- input: array, optional block with sorting logic
- output: sorted original array

Algorithm
- Loop until swapped equal false
  - Iterate from 1 to array size - 1 and assign to index
    - set first and second to array[index-1] and arrauy[index] respectively

    - if block given, set in_order to return block value from yielding first, second 
    - else set in_order to = first <= second
    
    - next if in_order is true
    - swap array[index-1], array[index] = second, first
    - swapped = true 
  - break unless swapped

=end

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      first, second = array[index - 1], array[index]
      
      if block_given?
        in_order = yield(first, second) 
      else 
        in_order = first <= second
      end
      
      next if in_order
      array[index - 1], array[index] = second, first
      swapped = true
    end

    break unless swapped
  end
  nil
end


array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)


=begin
Solution

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end

      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end

Discussion

Our solution is nearly identical to the original solution. The only difference
is that we have to yield two elements to the block if it was provided. If no
block is given, we just compare two elements, and use that to determine if the
two elements need to be swapped.

We use Kernel#block_given? to determine whether a block was provided to the
method. If it returns true, a block was provided; otherwise, a block wasn't
provided.

Regardless of whether a block is provided, we need to compare two elements
-- the previous element in the Array, and the current element, based on the
index variable. If no block is given, we can compare the values directly
using <=; otherwise, we need to yield both elements to the block, and examine
the return value of the block.

This technique of tweaking a general purpose method by passing it a block
is quite common. For instance, the Enumerable#sort method usually used to
sort Arrays accepts an optional block that can be used to modify the desired
sort sequence. Similarly, Enumerable#max and Enumerable#min take optional
blocks to determine how elements of a collection are compared when determining
the maximum and minimum values.

Further Exploration

Modify your solution so it only passes one element to the block at a time;
the block should perform some sort of transformation to the argument, and
#bubble_sort! itself should just use <= to compare two values. In other words,
you should be able to call #bubble_sort! like this:

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
=end

# Further Exploration
def bubble_sort2!(array)
  loop do
    swapped = false
    transformed = []
    array.each { |item| transformed << yield(item) }
    
    1.upto(array.size - 1) do |index|
      first, second = transformed[index - 1], transformed[index]
      next if first <= second
      array[index - 1], array[index] = array[index], array[index-1] 
      swapped = true
    end

    break unless swapped
  end
  nil
end

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort2!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)