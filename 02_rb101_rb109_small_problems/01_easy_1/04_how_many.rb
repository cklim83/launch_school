=begin

How Many?

Write a method that counts the number of occurrences of each element in
a given array.

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

count_occurrences(vehicles)

The words in the array are case-sensitive: 'suv' != 'SUV'. Once counted,
print each element alongside the number of occurrences.

Expected output:

car => 4
truck => 3
SUV => 1
motorcycle => 2

=end

def count_occurrences(array)
  hsh = Hash.new(0)
  array.each do |element|
    hsh[element] += 1
  end
  
  hsh.each do |key, value|
    puts "#{key} => #{value}"
  end
end

def count_occurrences_case_insensitive(array)
  hsh = Hash.new(0)
  array.each do |element|
    hsh[element.downcase] += 1
  end
  
  hsh.each do |key, value|
    puts "#{key} => #{value}"
  end
end

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

count_occurrences(vehicles)
puts ""
count_occurrences_case_insensitive(vehicles)

=begin

Solution

def count_occurrences(array)
  occurrences = {}

  array.uniq.each do |element|
    occurrences[element] = array.count(element)
  end

  occurrences.each do |element, count|
    puts "#{element} => #{count}"
  end
end


Discussion

As we iterate over each unique element, we create a new key-value pair
in occurrences, with the key as the element's value. To count each occurrence,
we use Array#count to count the number of elements with the same value.

Lastly, to print the desired output, we call #each on the newly created
occurrences, which lets us pass the keys and values as block parameters.
Then, inside of the block, we invoke #puts to print each key-value pair.

Further Exploration

Try to solve the problem when words are case insensitive, e.g. "suv" == "SUV".


TO REVIEW: Array#count and how it is used.

https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-count
count → int
count(obj) → int
count {|item| block} → int

Returns the number of elements.

If an argument is given, counts the number of elements which equal obj using ==.

If a block is given, counts the number of elements for which the block returns 
a true value.

ary = [1, 2, 4, 2]
ary.count                  #=> 4
ary.count(2)               #=> 2
ary.count {|x| x%2 == 0}   #=> 3

=end