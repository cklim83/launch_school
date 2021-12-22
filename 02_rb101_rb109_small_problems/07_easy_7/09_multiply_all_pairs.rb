=begin

Multiply All Pairs

Write a method that takes two Array arguments in which each Array contains
a list of numbers, and returns a new Array that contains the product of
every pair of numbers that can be formed between the elements of the two
Arrays. The results should be sorted by increasing value.

You may assume that neither argument is an empty Array.

Examples:

multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]
=end

=begin
Problem
- input: 2 arrays of numbers, that can have unequal number of elements. 
         Both are non-empty
- output: a new array containing the product of every pair of elements 
          (1 from each input array), sorted in ascending orders

Examples
- see above
- requirements:
  - 2 non-empty array of numbers (sized m, n) as inputs 
  - 1 array containing (m*n) elements, each is a pair product, sorted in ascending orders

Data Structure
- input: 2 array of numbers
- output: a new array of numbers

Algorithm
1. Set products = []
2. Iterate through each element of numbers_1 with block with paramter number_1
3. Within the block, iterate through each element of numbers_2 with block with parameter number_2
4. In the inner block, products << number_1 * number_2
5. Return products.sort!
=end

def multiply_all_pairs(numbers_1, numbers_2)
  products = []
  
  numbers_1.each do |number_1|
    numbers_2.each do |number_2|
      products << number_1 * number_2
    end
  end
  
  products.sort!
end

p multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]


=begin
Solution

def multiply_all_pairs(array_1, array_2)
  products = []
  array_1.each do |item_1|
    array_2.each do |item_2|
      products << item_1 * item_2
    end
  end
  products.sort
end

Discussion

For the above solution we have two iterators, one for the first array and one
for the second. We want all the different combinations of multiples, duplicates
included. To do this, we need to iterate through each item in the first array,
and then multiply it by each item in the second array. Finally, we sort our
array of products and return that array.

Just for fun, here is a more compact solution.

def multiply_all_pairs(array_1, array_2)
  array_1.product(array_2).map { |num1, num2| num1 * num2 }.sort
end

Further Exploration

What do you think? Did you go about solving this exercise differently?
What method did you end up using?
=end

=begin
To Review
- Array#product

  array_1.product(array_2).map { |num1, num2| num1 * num2 }.sort
=end