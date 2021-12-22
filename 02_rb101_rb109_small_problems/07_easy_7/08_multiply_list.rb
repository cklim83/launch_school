=begin

Multiply Lists

Write a method that takes two Array arguments in which each Array contains a
list of numbers, and returns a new Array that contains the product of each
pair of numbers from the arguments that have the same index. You may assume
that the arguments contain the same number of elements.

Examples:

multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]
=end

=begin
Problem
- input: two arrays of integers
- output: single array containing the multiplication of the elements of input arrays

Examples
- see above
- requirements
  - elements are numbers (integers, float)
  - both arrays have same number of elements
  - input_arraus can be empty
  - result is a new array
  

Data Structure
- input: 2 arrays of numbers
- output: a new array of numbers

Algorithm
1. Set multiplication_result = [], curr_index=0
2. while curr_index < arr_1.size
  a. multiplication_result << arr_1[curr_index] * arr_2[curr_index]
  b. curr_index += 1
3. return multiplication_result
=end

def multiply_list(arr_1, arr_2)
  multiplication_result = []
  curr_index = 0
  
  while curr_index < arr_1.size
    multiplication_result << arr_1[curr_index] * arr_2[curr_index]
    curr_index += 1
  end
  
  multiplication_result
end

p multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]


=begin
Solution

def multiply_list(list_1, list_2)
  products = []
  list_1.each_with_index do |item, index|
    products << item * list_2[index]
  end
  products
end

Discussion

We take a direct approach, and simply iterate an index into both Arrays,
appending each product to the products Array.

Further Exploration

The Array#zip method can be used to produce an extremely compact solution
to this method. Read the documentation for zip, and see if you can come up
with a one line solution (not counting the def and end lines).
=end


=begin
TO REVIEW
- Learn how zip can be used since both arrays have same number of elements.
https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-zip

a = [1, 2, 3]
b = [4, 5, 6]

a.zip(b) 
=> [[1, 4], [2, 5], [3, 6]]

a.zip(b) { |arr| p arr }  {zip will block will execute a the block and return nil, the block parameter will be assigned inner array
[1, 4]
[2, 5]
[3, 6]
=> nil

a.zip(b).map { |arr| arr[0]*arr[1] }   
=> [4, 10, 18]
=end