=begin

1) Below we have given you an array and a number. Write a program that checks 
to see if the number appears in the array.

arr = [1, 3, 5, 7, 9, 11]
number = 3

=end

arr = [1, 3, 5, 7, 9, 11]
number = 3
if arr.include?(number)
  puts "#{number} is present in the array!"
else
  puts "#{number} is not in the array!"
end


=begin

2) What will the following programs return? What is the value of arr after each?

1. arr = ["b", "a"]
   arr = arr.product(Array(1..3))       arr = [["b", 1], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
   arr.first.delete(arr.first.last)     arr = [["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]

2. arr = ["b", "a"]
   arr = arr.product([Array(1..3)])     arr = [["b", [1, 2, 3]], ["a", [1, 2, 3]]]
   arr.first.delete(arr.first.last)     arr = [["b", ["a", [1, 2, 3]]]
   
=end


=begin

3) How do you return the word "example" from the following array?

arr = [["test", "hello", "world"],["example", "mem"]]

arr[1][0]
arr.last.first

=end


=begin

4) What does each method return in the following example?

arr = [15, 7, 18, 5, 12, 8, 5, 1]

1. arr.index(5)     # returns 3, index of 1st instance of 5

2. arr.index[5]     # returns error, undefined method []

3. arr[5]           # returns 8

=end


=begin

5) What is the value of a, b, and c in the following program?

string = "Welcome to America!"
a = string[6]       a = "e"
b = string[11]      b = "A"
c = string[19]      c = nil

=end


=begin

6) You run the following code...

names = ['bob', 'joe', 'susan', 'margaret']
names['margaret'] = 'jody'

...and get the following error message:

TypeError: no implicit conversion of String into Integer
  from (irb):2:in `[]='
  from (irb):2
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
  
What is the problem and how can it be fixed?

names array was expecting an integer as the index but instead got a string 'margaret', 
hence triggering the implicit string to integer conversion.
The intent seemed to be replacing value from 'margaret' to 'jody'

=end

names = ['bob', 'joe', 'susan', 'margaret']
names[names.index('margaret')] = 'jody'   # If we do not know the index of margaret
names[3] = 'jody'                         # if index is known


=begin

7) Use the each_with_index method to iterate through an array of your creation 
that prints each index and value of the array.

=end

my_array = ["elijah", "david", "grace"]

my_array.each_with_index do |value, idx| 
  puts "#{idx + 1}: #{value.capitalize}"
end


=begin

8) Write a program that iterates over an array and builds a new array that is the 
result of incrementing each value in the original array by a value of 2. You should
have two arrays at the end of this program, The original array and the new array
you've created. Print both arrays to the screen using the p method instead of puts.

=end

orig_array = [1, 2, 3, 4, 5]
new_array = orig_array.map { |x| x+2 }

p orig_array
p new_array