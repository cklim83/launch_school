# Below we have given you an array and a number. Write a program that checks to see if the number appears in the array.
arr = [1, 3, 5, 7, 9, 11]
number = 3

if arr.include?(number)
  puts "#{number} is found in #{arr}"
else
  puts "#{number} is not found in #{arr}"
end


=begin
What will the following programs return? What is the value of arr after each?

1. arr = ["b", "a"]
   arr = arr.product(Array(1..3))
   arr.first.delete(arr.first.last)
   
   Answer: 
   
   arr = [["b", "1"], ["b", "2"], ["b", "3"], ["a", "1"], ["a", "2"], ["a", "3"]] after product function
   Last statement removes "1" from ["b", "1"] in arr. Thus the return value is "1".
   As delete is an inplace function i.e. modifies the caller, value of arr becomes
   [["b"], ["b", "2"], ["b", "3"], ["a", "1"], ["a", "2"], ["a", "3"]] 

2. arr = ["b", "a"]
   arr = arr.product([Array(1..3)])
   arr.first.delete(arr.first.last)
   
   Answer:
   arr = [["b", [1, 2, 3]], ["a", [1, 2, 3]]]
   delete will return [1, 2, 3]
   arr becomes [["b"], ["a", [1, 2, 3]]]
   
=end


# How do you return the word "example" from the following array?

arr = [["test", "hello", "world"],["example", "mem"]]
puts arr.last.first
puts arr[-1][0]


=begin

What does each method return in the following example?

arr = [15, 7, 18, 5, 12, 8, 5, 1]

1. arr.index(5)   => 3

2. arr.index[5]   => arr.index returns an enumerator. But enumerator cannot be indexed. Thus, it returns undefined method '[]' for # Enumerator

3. arr[5]         => 8

=end


=begin

What is the value of a, b, and c in the following program?

string = "Welcome to America!"
a = string[6]   => 'e'
b = string[11]  => 'A'
c = string[19]  => nil. Out of index returns nil rather than throw an error.

=end


=begin
You run the following code...

names = ['bob', 'joe', 'susan', 'margaret']
names['margaret'] = 'jody'

...and get the following error message:

TypeError: no implicit conversion of String into Integer
  from (irb):2:in `[]='
  from (irb):2
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'

What is the problem and how can it be fixed?

Answer: 
[] accepts an integer as parameter so putting 'margaret' caused a string to integer conversion error
To replace 'margaret' with 'jody', we could find the index of margaret within the []

names[name.index('margaret')] = 'jody'

index function will return nil if the name is not found. In that case, names[nil] will again generate a no implicit conversion from nil to integer error.

=end


# Use the each_with_index method to iterate through an array of your creation that prints each index and value of the array.
football_clubs = ['liverpool', 'man city', 'chelsea', 'wolves']
football_clubs.each_with_index { |club, index| puts "Rank #{index+1}: #{club}" }


# Write a program that iterates over an array and builds a new array that is the result of incrementing each value in the original array by a value of 2. 
# You should have two arrays at the end of this program, The original array and the new array you've created. Print both arrays to the screen using the 
# p method instead of puts.

orig_arr = [1, 2, 3, 4, 5]
new_arr = orig_arr.map {|val| val + 2 }  # map returns the result of block on each element in new array and is used for transformation. each returns original array and is used for iteration.
p orig_arr
p new_arr
