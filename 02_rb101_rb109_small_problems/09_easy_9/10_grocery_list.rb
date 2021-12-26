=begin

Grocery List

Write a method which takes a grocery list (array) of fruits with quantities
and converts it into an array of the correct number of each fruit.

Example:

buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]
=end
  
def buy_fruit(fruits)
  result = []
  fruits.to_h.each do |fruit, count|
    count.times { result << fruit }
  end
  
  result
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]


=begin
Solution

Solution 1

def buy_fruit(list)
  expanded_list = []

  list.each do |item|
    fruit, quantity = item[0], item[1]
    quantity.times { expanded_list << fruit }
  end

  expanded_list
end

Solution 2

def buy_fruit(list)
  list.map { |fruit, quantity| [fruit] * quantity }.flatten
end

Discussion

In the first solution, we define a new array expanded_list and then iterate
over the array passed in as an argument. For each subarray, we grab the
quantity and the name of the fruit by using index reference and push each
string the required number of times into our new array. We use the
Integer#times method in order to execute the content of the block for the
number of times specified by the caller, here quantity. On each iteration
the block is executed and the fruit string is appended to our expanded list.

Note that we could use the block parameters to access each element of the 
subarrays, like this:

list.each do |fruit, quantity|
  quantity.times { expanded_list << fruit }
end

The second solution is more compact. We choose to use map in order to return
a transformation of the array passed in as an argument. Here again we use the
block parameters to access each element of the subarrays. We realize that we
want to multiply each fruit by the given quantity, and try this:

fruit * quantity => "applesapplesapples"

This is not exactly what we want! We are doing string concatenation when in
fact we want an array containing the required quantity of each fruit as
separate strings. Let's try something else:

[fruit] * quantity => ["apples", "apples", "apples"]

Great! We are almost done. We now have an array containing all of our fruits
in nested subarrays:

[["apples", "apples", "apples"], ["orange"], ["bananas", "bananas"]]

All we need is Array#flatten to reduce it down to a single large array.
=end


=begin
TO REVIEW
- "str" * 2 yields "strstr" not ["str", "str"]
- ["str"] * 2 gives us the correct result
- We do not have to convert the nested array to hash
=end