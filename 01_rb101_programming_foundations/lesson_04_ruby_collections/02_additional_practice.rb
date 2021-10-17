=begin
Practice Problem 1

Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

Turn this array into a hash where the names are the keys and the values are 
the positions in the array.

My answer:

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hsh = {}

flintstones.each_with_index do |item, index|
  flintstones_hsh[item.to_sym] = index
end

counter = 0
result = flintstones.each_with_object({}) do |item, hash|
  hash[item.to_sym] = counter
  counter += 1
end

Given solution:

flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

=end

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hsh = {}

flintstones.each_with_index do |item, index|
  flintstones_hsh[item.to_sym] = index
end

p flintstones_hsh

counter = 0
result = flintstones.each_with_object({}) do |item, hash|
  hash[item.to_sym] = counter
  counter += 1
end

p result


=begin
Practice Problem 2

Add up all of the ages from the Munster family hash:

ages = { 
  "Herman" => 32, 
  "Lily" => 30, 
  "Grandpa" => 5843, 
  "Eddie" => 10, 
  "Marilyn" => 22, 
  "Spot" => 237 
}

My answer:
Use Hash#values to access the values array. Than use enumerable#reduce or Array#sum

https://docs.ruby-lang.org/en/2.6.0/Enumerable.html#method-i-reduce, inject is an alias
https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-sum

ages.values.reduce(:+)
ages.values.reduce { |accum, value| accum + value }
ages.values.sum


Given answer:
One solution would be to assign a variable to an initial value of 0 and
then iterate through the Hash adding each value in turn to the total.

total_ages = 0
ages.each { |_,age| total_ages += age }
total_ages # => 6174

Another option would be to use a Enumerable#inject method.

ages.values.inject(:+) # => 6174

This uses ages.values to make an array, then uses the inject method
which is part of the Enumerable module. The strange-looking parameter
to inject is simply a variety of the inject method which says
"apply the + operator to the accumulator and object parameters of inject".

As we have previously discussed, Enumerable is included in Array, and
it can be useful to augment your knowledge of what you can do with
arrays by studying Enumerable. When faced with a problem such as this
one however, don't get tempted to go 'method hunting' in order to
reach a solution. As demonstrated, even if you don't know the #inject
method, the problem can be solved equally well by using #each to
iterate through the Hash; you could even use a basic loop to reach
the same result.

=end

ages = { 
  "Herman" => 32, 
  "Lily" => 30, 
  "Grandpa" => 5843, 
  "Eddie" => 10, 
  "Marilyn" => 22, 
  "Spot" => 237 
}

p ages.values.reduce(:+)
p ages.values.reduce { |accum, value| accum + value }
p ages.values.sum


=begin
Practice Problem 3

In the age hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

remove people with age 100 and greater.

My answer:
# select all that are below 100 in new hash.
ages.select { |_, age| age < 100 } 

# destructively pairs which block return as truthy and return altered hash
ages.delete_if { |_, age| age >= 100 }  


Given answer:

ages.keep_if { |_, age| age < 100 }

You could also use #select! here. When using similar methods however, it
is important to be aware of the subtle differences in their implementation.
For example, the Ruby Documentation for Hash#select! tells us that it is
"Equivalent to Hash#keep_if, but returns nil if no changes were made",
though in this case that wouldn't have made any difference.
=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# select all that are below 100 in new hash.
p ages.select { |_, age| age < 100 } 

p ages
# destructively pairs which block return as truthy and return altered hash
p ages.delete_if { |_, age| age >= 100 } 


=begin
Practice Problem 4

Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, 
"Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

My answer:
https://medium.com/@jaredrayjohnson1/ruby-operators-double-pipe-equals-bfcbe21a7177

A) minimum_age = nil
   ages.each do |_, age|
     minimum_age ||= age  # assign age to minimum_age only if minimum_age is falsey
     minimum_age = age if age < minimum_age
   end

   p minimum_age

B) ages.values.min


Given answer:
ages.values.min

=end

ages = { 
  "Herman" => 32, 
  "Lily" => 30, 
  "Grandpa" => 5843, 
  "Eddie" => 10, 
  "Marilyn" => 22, 
  "Spot" => 237 
}

minimum_age = nil
ages.each do |_, age|
  minimum_age ||= age  # assign age to minimum_age only if minimum_age is falsey
  minimum_age = age if age < minimum_age
end

p minimum_age

p ages.values.min


=begin
Practice Problem 5

In the array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

Find the index of the first name that starts with "Be"

My answer:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

search_index = nil
flintstones.each_with_index do |name, index|
  A) search_index = index if name.start_with?('Be') OR 
  B) search_index = index if name.match(/^Be/) # regex for beginning ^Be
end


Given answer:
flintstones.index { |name| name[0, 2] == "Be" }

=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
search_index = nil
flintstones.each_with_index do |name, index|
  search_index = index if name.match(/^Be/) # regex for pattern beginning 'Be'
end

p search_index  

search_index = nil
flintstones.each_with_index do |name, index|
  search_index = index if name.start_with?('Be')
end

p search_index  


=begin
Practice Problem 6

Amend this array so that the names are all shortened to just the first three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

My answer:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name| name[0, 3] }
p flintstones


Given answer:
flintstones.map! { |name| name[0,3] }

=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name| name[0, 3] }
p flintstones


=begin
Practice Problem 7

Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

ex:

{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

My answer:
statement = "The Flintstones Rock"

letter_counter = {}
statement.each_char do |letter|
  next if letter == ' '
  if letter_counter[letter]
    letter_counter[letter] += 1
  else
    letter_counter[letter] = 1
  end
end
p letter_counter


Given answer:

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

p result

TO REVIEW: String#count and how it can be used as a counter.
=end

statement = "The Flintstones Rock"

letter_counter = {}
statement.each_char do |letter|
  next if letter == ' '
  if letter_counter[letter]
    letter_counter[letter] += 1
  else
    letter_counter[letter] = 1
  end
end
p letter_counter


result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

p result


=begin
Practice Problem 8

What happens when we modify an array while we are iterating 
over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

My answer:
We get unexpected answers when we are moditfying an array while
iterating over it. Array#shift(n) removes the first n elements
from the array. In the first iteration, the block prints 1, then
destructively remove 1 from the array, causing the number pointer
to point to 2 before the end of current iteration. It then shift 
right by oneelement in iteration 2, pointing and printing 3 on the
same line, then removing 2 from numbers. In the next iteration, it 
point and print 4 and then remove 3 from numbers before returning
numbers holding just [4]

134
=>[4]


Given answer:

first one...

1
3

To better understand what is happening here, we augment our loop
with some additional "debugging" information:

numbers = [1, 2, 3, 4]
numbers.each_with_index do |number, index|
  p "#{index}  #{numbers.inspect}  #{number}"
  numbers.shift(1)
end

The output is:

"0  [1, 2, 3, 4]  1"
"1  [2, 3, 4]  3"

From this we see that our array is being changed as we go 
(shortened and shifted), and the loop counter used by #each
is compared against the current length of the array rather
than its original length.

In our first example, the removal of the first item in the
first pass changes the value found for the second pass.


What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

My answer:
12
=>[1, 2]

Pop(n) destructively remove and return n elements from the back of the array.

In the first iteration, 1 is printed and 4 is removed, leaving numbers
as [1, 2, 3]. In second iteration, number is 2 which is printed and
3 is popped, leaving numbers as [1, 2] with no more items left to iterate.
Hence each terminates and return numbers which is now [1, 2].


Given answer:

second one...
1
2

In our second example, we are shortening the array each pass just as in
the first example...but the items removed are beyond the point we are
sampling from in the abbreviated loop.

In both cases we see that iterators DO NOT work on a copy of the original
array or from stale meta-data (length) about the array. They operate on
the original array in real time.


TO REVIEW:

- p will print each iteration with \n, so the output should not be on the same
line. However p [1,2,3] will print "[1,2,3]\n" but puts [1,2,3] will be "1\n2\n3\n"

- My understanding of where the iterator is pointing after the destructive operation
on the original array is incorrect. At each iteration, the iterator will point
to the next index (0..n) of the updated array. My understanding that after the first
shift in the first iterator, it will shift the iterator to point the second item of the
old array is incorrect.
=end

# First example with debugging
numbers = [1, 2, 3, 4, 5, 6, 7]
numbers.each_with_index do |number, index|
  p "#{index}  #{numbers.inspect}  #{number}"
  numbers.shift(1)
end
p numbers

# Second example with debugging
numbers = [1, 2, 3, 4, 5, 6, 7]
numbers.each_with_index do |number, index|
  p "#{index}  #{numbers.inspect}  #{number}"
  numbers.pop(1)
end
p numbers


=begin
Practice Problem 9

As we have seen previously we can use some built-in string methods to change the case
of a string. A notably missing method is something provided in Rails, but not in Ruby
itself...titleize. This method in Ruby on Rails creates a string that has each word
capitalized as it would be in a title. For example, the string:

words = "the flintstones rock"

would be:

words = "The Flintstones Rock"

Write your own version of the rails titleize implementation.

My answer:
See below


Given answer:

words.split.map { |word| word.capitalize }.join(' ')

=end

# Problem
# Input: string with multiple words
# Output: Each word in string should have first char in upper case

# Examples:
# titleize("the flintstones rock") => "The Flintstones Rock"
# Assumptions: 
# - Words are delimited by single space character
# - the first character in every word is a alphabet that can be uppercase!
# - the input string consists of only ascii
# - Return an empty string if input is an empty string (Edge case)

# Data Structure:
# Input: String
# Output: String
# Intermediate: Array of words

# Algorithm
# - Split the string into collection of words with space as delimiter 
# - For each word, change the first character into upper case
# - Join back the collection of words into same order and return it.

def titleize(sentence)
  words = sentence.split
  words.map! do |word|
    word.capitalize
  end

  words.join(' ')
end

words = "the flintstones rock"

p titleize(words) == "The Flintstones Rock"


=begin
Practice Problem 10

Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

Modify the hash such that each member of the Munster family has an additional
"age_group" key that has one of three values describing the age group the family
member is in (kid, adult, or senior). Your solution should produce the hash below

{ "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

My answer: 
See both errors and new attempt.


Given answer:

munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end

TO REVIEW: 
- Conceptual errors on how to manipulate the inner hash given my mistakes below.
=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


# Wrong Answer Number 1
# munsters.values returns a new array with elements referencing values of munsters
# which corresponds to inner hashes containing the age and gender of each member
# of the family. block local variable member_details will reference and iterate the 
# inner hash of each family member. Since member_details is pointing to an inner
# hash of a munster family member for each iteration, member_details["age_group"]=
# actually mutates that inner hash of munsters as required since Hash#[]= is
# destructive. There is confusion map! is required to mutate the inner hash of munsters.
# This thinking is misguided since map! will replace the elements in the new
# array previously holding the inner hashes of munster, not munster itself which is
# what we we need and already achieved by member_details[]= in the block. So whether
# we use map!, map or even each as the method doesnt actually matter since we are not
# interested in the return value of these method. 

# At the end, map_return will hold just the string objects "kid", "adult",
# "senior" for munster family members. Checking the object id of the altered
# munsters for inner age_group key confirmed they are the same object since
# they have the same object ids.

map_return = munsters.values.map! do |member_details|
  age = member_details["age"]
  age_group = ""
  if age.between?(0, 17)
    member_details["age_group"] = "kid"
  elsif age.between?(18, 64)
    member_details["age_group"] = "adult"
  else
    member_details["age_group"] = "senior"
  end
end

p map_return
map_return.each do |item|
  p item
  p item.object_id
end

munsters.values.each do |item|
  p item["age_group"]
  p item["age_group"].object_id
end


# Another Possible Conceptual Error
# munsters.values returns a new array with elements referencing values of 
# munsters which corresponds to inner hashes containing the age and gender 
# of each member of the family. block local variable member_details will
# reference and iterate the inner hash of each family member. Assigning 
# member_details to the correct age category string is actually meaningless
# since it is just redirecting this temporary variable to reference new string 
# objects and does not alter the values in munsters. map! will accept the
# return value of the block. Since if is the last statement of the block, each
# iteration will return one of "kid", "adult" or "senior" and replace current
# elements previously holding inner hashes of munsters. Thus this code doesnt
# do what we need to alter munster and introduce the age_group values.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.values.map! do |member_details|
  age = member_details["age"]
  age_group = ""
  if age.between?(0, 17)
    member_details = "kid"
  elsif age.between?(18, 64)
    member_details = "adult"
  else
    member_details = "senior"
  end
end


# New attempt
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, details|
  age = details["age"]
  if age.between?(0, 17)
    details["age_group"] = "kid"
  elsif age.between?(18, 64)
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end

p munsters