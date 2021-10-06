=begin
Question 1

In this hash of people and their age,

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

see if "Spot" is present.

Bonus: What are two other hash methods that would work just as well for this solution?

My answer: 
- ages['Spot'] -> returns nil if there is no key == 'Spot'. Else return value associated with 'Spot'

Bonus answer
- ages.has_key?('Spot') -> returns true/false
- ages.fetch('Spot', [default_value]) -> raise KeyError if key is absent and optional default value not provided. 
                                         Returns default value if provided and key absent. 

Given answer:
- ages.key?("Spot")

Bonus Answer:
- Hash#include? and Hash#member?

=end


=begin
Question 2

Starting with this string:

munsters_description = "The Munsters are creepy in a good way."

Convert the string in the following ways (code will be executed on original munsters_description above):

"tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
"The munsters are creepy in a good way."
"the munsters are creepy in a good way."
"THE MUNSTERS ARE CREEPY IN A GOOD WAY."

My answer: 
See below

Given answer:
munsters_description.swapcase!
munsters_description.capitalize!
munsters_description.downcase!
munsters_description.upcase!

=end

munsters_description = "The Munsters are creepy in a good way."
p munsters_description.swapcase
p munsters_description.capitalize
p munsters_description.downcase
p munsters_description.upcase


=begin
Question 3

We have most of the Munster family in our age hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

add ages for Marilyn and Spot to the existing hash

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

My answer: 
Hash#merge!. See below

Given answer:
ages.merge!(additional_ages)

=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)
p ages


=begin
Question 4

See if the name "Dino" appears in the string below:

advice = "Few things in life are as important as house training your pet dinosaur."

My answer:
String#include?
String#match?(/pattern/)

Given answer:
advice.match?("Dino")
# Note that this is not a perfect solution, as it would match any substring with Dino in it.

=end

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?("Dino")
p advice.match?("Dino")


=begin
Question 5

Show an easier way to write this array:

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

My answer: 
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

Given answer:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
puts flintstones.inspect


=begin
Question 6

How can we add the family pet "Dino" to our usual array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

My answer:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles) 
 - flintstones << "Dino"
 - flintstones.append("Dino")
 

Given answer:
flintstones << "Dino"

=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles) 
flintstones.append("Dino")
puts flintstones.inspect


=begin
Question 7

In the previous practice problem we added Dino to our array like this:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"

We could have used either Array#concat or Array#push to add Dino to the family.

How can we add multiple items to our array? (Dino and Hoppy)

My answer:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.append("Dino", "Hoppy") OR flinstones.push("Dino", "Hoppy"). Array#append and Array#push are alias
flintstones.concat(["Dino", "Hoppy"])

Given answer:
flintstones.push("Dino").push("Hoppy")   # push returns the array so we can chain
flintstones.concat(%w(Dino Hoppy))  # concat adds an array rather than one item
=end

puts("")
puts("Question 7")
puts("------Using Array#append(obj_1, obj_2 ...) -------")
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.append("Dino", "Hoppy")  

puts("------Using Array#push(obj_1, obj_2 ...) -------")
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.push("Dino", "Hoppy")

puts("------Using Array#concat([obj_1, obj_2 ...]) -------")
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.concat(["Dino", "Hoppy"])


=begin
Question 8

Shorten the following sentence:

advice = "Few things in life are as important as house training your pet dinosaur."

Review the String#slice! documentation, and use that method to make the return value "Few things in life are as important as ". 
But leave the advice variable as "house training your pet dinosaur.".

As a bonus, what happens if you use the String#slice method instead?

My answer:
Using regex: advice.slice!(/^F.*t as /)
Bonus: If we use String#slice instead, we will get the same return value as slice! but advice will retain the original string as it is
unchanged by String#slice.


Given answer:
advice.slice!(0, advice.index('house'))  # => "Few things in life are as important as "
p advice # => "house training your pet dinosaur."

Bonus: Using slice, the non-destructive version of slice!, would return a new string with the same text 
("Few things in life are as important as ") but the advice variable would remain the same, pointing to 
the original string ("Few things in life are as important as house training your pet dinosaur.").
=end

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!(/^F.*t as /)
p advice

advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!(0, advice.index('house'))  # => "Few things in life are as important as "
p advice # => "house training your pet dinosaur."


=begin
Question 9

Write a one-liner to count the number of lower-case 't' characters in the following string:

statement = "The Flintstones Rock!"
My answer:
statement.count('t')
To review the documentation for String#count

Given answer:
statement.count('t')
=end

statement = "The Flintstones Rock!"
statement.count("t")


=begin
Question 10

Back in the stone age (before CSS) we used spaces to align things on the screen. If we had a table 
of Flintstone family members that was forty characters in width, how could we easily center 
that title above the table with spaces?

title = "Flintstone Family Members"

My answer:
String#center(width, ' ') https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-center

Given answer:
title.center(40) # as default padding is already space.

=end

title = "Flintstone Family Members"
p title.center(40, ' ')
