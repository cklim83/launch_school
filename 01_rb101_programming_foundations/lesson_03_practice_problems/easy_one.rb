=begin
Question 1

What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

My answer: [1, 2, 3]

Correct Answer:
1
2
2
3 
=> nil

Explanation: uniq returns a NEW array with unique elements. Hence numbers 
retains it original values. When puts is called on an array, it prints 
each item on a new line. 

If p is used instead, it will call the inspect method on the argument.
inspect returns the string form of a provided argument, "[1, 2, 2, 3]" 
in this case. p then prints that string and returns the original object. 

Calling puts numbers.inspect will print the same output string, but with 
a different return value nil.

=end

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
p numbers
puts numbers.inspect


=begin
Question 2

Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

    what is != and where should you use it?
    put ! before something, like !user_name
    put ! after something, like words.uniq!
    put ? before something
    put ? after something
    put !! before something, like !!user_name

My answer:
In Ruby, ! is often used as prefixes before conditional statements to invert the truthiness of the value. 
It is also used as suffixes to method names to indicate that method mutates the caller, or its arguments.

In Ruby, ? is used as a ternary operator placed between a conditional and the statements to be executed,
depending on whether the conditional expression evaluates to true or false. ? is also appended to method
names to indicate that the method returns a boolean value and doesn't mutate the caller or its arguments

!= is a comparator and is used to in conditionals to compare two operands. It returns true if they are different
and false otherwise.

!user_name inverts the truthiness of the value held by variable user_name. If user_name holds values nil or false
!user_name will return true, it will return false otherwise.

! after something, like words.uniq! meant that the method mutates the caller.
? before something usually used in ternary operations like conditional ? execute this if true : execute this if false
? after something usually used in method_names to indicate method returns a boolean value and doesn't mutate caller
!! inverts the truthiness of variable twice, which is as good as the original truthiness of the variable.

Given amswer:
if you see ! or ? at the end of the method, it's actually part of the method name, and not Ruby syntax. 
Therefore, you really don't know what the method is doing, even if it ends in those characters -- 
it depends on the method implementation. The other uses are actual Ruby syntax:

    != means "not equals"
    ? : is the ternary operator for if...else
    !!<some object> is used to turn any object into their boolean equivalent. (Try it in irb)
    !<some object> is used to turn any object into the opposite of their boolean equivalent, just like the above, but opposite.

=end


=begin
Question 3

Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."

My answer: see below

Given answer:
advice.gsub!('important', 'urgent')
=end

advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!(/important/, "urgent")
puts advice


=begin
Question 4

The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]

What do the following method calls do (assume we reset numbers to the original array between method calls)?

numbers.delete_at(1)
numbers.delete(1)

My answer: 
delete_at takes an index of the array as argument, delete the item at that index permanently from the array and 
returns the value of that item. It doesnt mutate the array if provided position is out of index and returns nil.

delete used the value of provided argument and deletes all occurrence in the array permanently. It returns the value of argument.
If value is not found in array, array is not mutated and nil is returned.

Given answer:
numbers.delete_at(1) # numbers is now [1, 3, 4, 5]

(note that the array is operated on directly and the return value of the call is the removed item 2)

numbers.delete(1) # numbers is now [2, 3, 4, 5]

(note that the array is operated on directly and the return value of the call is the removed item 1)

Another thing to notice is that while both of these methods operate on the contents of the referenced 
array and modify it in place (rather than just returning a modified version of the array) these methods 
do NOT have the usual ! at the end of the method name for "modify in place" method names.

=end


=begin
Question 5

Programmatically determine if 42 lies between 10 and 100.

hint: Use Ruby's range object in your solution.

My answer:
42 in 10..100. 
Conveniently assumed from python 42 in range(10,100) but this resulted in 
Syntax error, unexpected in, expecting end-of-input

Checked ruby documentation https://docs.ruby-lang.org/en/2.6.0/Range.html#method-i-include-3F
and realised range objects has built-in include method. Hence new solution becomes: 
(10..100).include?(42)

Also note that .. is inclusive of the upper range, while ... excludes. AND
range object A..B or A...B is only for counting up, it doesnt work for counting down 

Given answer:
(10..100).cover?(42)

Personal notes comparing cover? and include? methods for range objects:
(a..b).cover?(obj) or (a..b).cover?(c..d) 
-> cover? accepts both an obj or a range. Include? only accepts an object. If provided a range include? will returns false even if range fully subsumes within caller
-> cover? and include? both are inclusive of end values unless the calling range object excludes the end value i.e. a...b
-> Both methods works for numeric, float and alphabets.
  (10..100).include?(15.4) => true
  (10..100).covers?(15.4) => true
  ("a".."d").include?("b") => true
  ("a".."d").cover?("b") => true
-> But they differ below:
  ("a".."d").include?("bb") => false
  ("a".."d").cover?("bb") => true

=end

(10..100).include?(42)
p (10..20).to_a
p (10...20).to_a
p (20..10).to_a #=> []


=begin

Question 6

Starting with the string:

famous_words = "seven years ago..."

show two different ways to put the expected "Four score and " in front of it.

My answer:
famous_words = "seven years ago..."
1) famous_words = "Four score and " + famous_words
2) famous_words.insert(0, "Four score and ")

Given anwer:
"Four score and " + famous_words OR

famous_words.prepend("Four score and ") OR

"Four score and " << famous_words

=end

famous_words = "seven years ago..."
p famous_words = "Four score and " + famous_words
famous_words = "seven years ago..."
p famous_words.insert(0, "Four score and ")


=begin
Question 7

If we build an array like this:

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

We will end up with this "nested" array:

["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

Make this into an un-nested array.

My answer: use the Array#flatten! (see below)

Given answer: 
flintstones.flatten!

=end

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

p flintstones.flatten!


=begin
Question 8

Given the hash below

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

Turn this into an array containing only two elements: Barney's name and Barney's number

My answer:
flintstones.select { |key| key == 'Barney' }
=> { "Barney" => 2 }. Wrong as we want the result to be an array but select returns a hash.


Given answer:
flintstones.assoc("Barney")
#=> ["Barney", 2]

See https://docs.ruby-lang.org/en/2.6.0/Hash.html#method-i-assoc
 assoc(obj) → an_array or nil

Searches through the hash comparing obj with the key using ==. Returns the key-value pair (two elements array) or nil if no match is found.

Examples
h = {"colors"  => ["red", "blue", "green"],
     "letters" => ["a", "b", "c" ]}
h.assoc("letters")  #=> ["letters", ["a", "b", "c"]]
h.assoc("foo")      #=> nil

=end

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
p flintstones.assoc("Barney")