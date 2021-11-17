=begin

How old is Teddy?

Build a program that randomly generates and prints Teddy's age.
To get the age, you should generate a random number between 20 and 200.

Example Output

Teddy is 69 years old!

=end

teddy_age = rand(20..200) 
puts "Teddy is #{teddy_age} years old!"


=begin

Solution

age = rand(20..200)
puts "Teddy is #{age} years old!"

Discussion

Our solution uses Kernel#rand with a range (20..200) as an argument.
This use is described in the documentation for rand, although it is
kind of an afterthought.

Nevertheless, the use of a range to limit the output value is an enormous
help here, so we use it to generate Teddy's age. Afterward, all we have to
do is print the result.

Further Exploration

Modify this program to ask for a name, and then print the age for that
person. For an extra challenge, use "Teddy" as the name if no name is entered.


https://docs.ruby-lang.org/en/2.6.0/Kernel.html#method-i-rand

rand(max=0) → number

If called without an argument, or if max.to_i.abs == 0, rand returns a
pseudo-random floating point number between 0.0 and 1.0, including 0.0
and excluding 1.0.

rand        #=> 0.2725926052826416

When max.abs is greater than or equal to 1, rand returns a pseudo-random
integer greater than or equal to 0 and less than max.to_i.abs.

rand(100)   #=> 12

** When max is a Range, rand returns a random number where 
range.member?(number) == true. ** (a integer that is a member of the Range)

Negative or floating point values for max are allowed, but may give
surprising results.

rand(-100) # => 87
rand(-0.5) # => 0.8130921818028143
rand(1.9)  # equivalent to rand(1), which is always 0

=end