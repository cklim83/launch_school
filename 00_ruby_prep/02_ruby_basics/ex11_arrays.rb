=begin

1) In the code below, an array containing different types of pets is assigned to pets.

pets = ['cat', 'dog', 'fish', 'lizard']

Select 'fish' from pets, assign the return value to a variable named my_pet, then print the value of my_pet.

Expected output:
I have a pet fish!

=end

pets = ['cat', 'dog', 'fish', 'lizard']
my_pet = pets[2]

puts "I have a pet #{my_pet}!"


=begin

2) In the code below, an array containing different types of pets is assigned to pets.

pets = ['cat', 'dog', 'fish', 'lizard']

Write some code that selects 'fish' and 'lizard' from the pets array - select the two 
items at the same time. Assign the return value to a variable named my_pets, then 
print the contents of my_pets as a single string, e.g.:

I have a pet fish and a pet lizard!

Make sure you use my_pets to get the words "fish" and "lizard" in that message.

=end


pets = ['cat', 'dog', 'fish', 'lizard']

my_pets = pets.select { |pet| pet.include?('i') }

puts "I have a pet #{my_pets.first} and a pet #{my_pets.last}!"


=begin

3) In the code below, an array containing different types of pets is assigned to pets. 
Also, the return value of pets[2..3], which is ['fish', 'lizard'], is assigned to my_pets.

pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]

Remove 'lizard' from my_pets then print the value of my_pets.

Expected output:
I have a pet fish!

=end

pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop

puts "I have a pet #{my_pets[0]}!"


=begin

4) Using the code below, select 'dog' from pets, add the return value to my_pets, 
then print the value of my_pets.

pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop

Expected output:

I have a pet fish and a pet dog!

=end


pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop

my_pets << pets[1]

puts "I have a pet #{my_pets[0]} and a pet #{my_pets[1]}!"


=begin

5) In the code below, an array containing different types of colors is assigned 
to colors.

colors = ['red', 'yellow', 'purple', 'green']

Use Array#each to iterate over colors and print each element.

Expected output:
I'm the color red!
I'm the color yellow!
I'm the color purple!
I'm the color green!

=end

colors = ['red', 'yellow', 'purple', 'green']

colors.each { |color| puts "I'm the color #{color}!" }


=begin

6) In the code below, an array containing the numbers 1 through 5 is assigned 
to numbers.

numbers = [1, 2, 3, 4, 5]

Use Array#map to iterate over numbers and return a new array with each number 
doubled. Assign the returned array to a variable named doubled_numbers and print 
its value using #p.

Expected output:
[2, 4, 6, 8, 10]

=end

numbers = [1, 2, 3, 4, 5]

doubled_numbers = numbers.map { |num| num * 2 }

p doubled_numbers


=begin

7) In the code below, an array containing five numbers is assigned to numbers.

numbers = [5, 9, 21, 26, 39]

Use Array#select to iterate over numbers and return a new array that contains 
only numbers divisible by three. Assign the returned array to a variable named 
divisible_by_three and print its value using #p.

Expected output:
[9, 21, 39]

=end

numbers = [5, 9, 21, 26, 39]

divisible_by_three = numbers.select { |number| number % 3 == 0 }
p divisible_by_three


=begin

8) The following array contains three names and numbers. Group each name with 
the number following it by placing the pair in their own array. Then create a 
nested array containing all three groups. What does this look like? 
(You don't need to write any code here. Just alter the value shown so it meets 
the exercise requirements.)

['Dave', 7, 'Miranda', 3, 'Jason', 11]

=end

p [['Dave', 7], ['Miranda', 3], ['Jason', 11]]


=begin

9) In the code below, a nested array containing three groups of names and 
numbers is assigned to favorites.

favorites = [['Dave', 7], ['Miranda', 3], ['Jason', 11]]

Flatten and print this array. That is, the printed result should not have 
any subarrays, but should have all of the original strings and numbers 
from the original array:

Expected output:
["Dave", 7, "Miranda", 3, "Jason", 11]

=end

favorites = [['Dave', 7], ['Miranda', 3], ['Jason', 11]]
p favorites.flatten


=begin

10) In the code below, two arrays containing several numbers are assigned 
to two variables, array1 and array2.

array1 = [1, 5, 9]
array2 = [1, 9, 5]

Compare array1 and array2 and print true or false based on whether they match.

=end

array1 = [1, 5, 9]
array2 = [1, 9, 5]

puts array1==array2