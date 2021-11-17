=begin

Mutation

What will the following code print, and why? Don't run the code 
until you have tried to answer.

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2


My answer:
Moe
Larry
CURLY
SHEMP
Harpo
CHICO
Groucho
Zeppo

array1.each { |value| array2 << value } cause array2 to reference the same element objects at array1. 
By calling a destructive method upcase! to modify string elements in array1 via 
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
thus also affects the values in array2


Given answer:

Solution

Moe
Larry
CURLY
SHEMP
Harpo
CHICO
Groucho
Zeppo

Discussion

Wait a minute! We changed Curly to CURLY, Shemp to SHEMP, and Chico to CHICO in array1. 
How'd those changes end up in array2 as well?

The answer lies in the fact that the first each loop simply copies a bunch of references
from array1 to array2. When that first loop completes, both arrays not only contain the
same values, they contain the same String objects. If you modify one of those Strings,
that modification will show up in both Arrays.

If this answer surprises you, reread the section on Pass by Reference vs Pass by Value
in Lesson 2 of Programming Foundations. To be successful with ruby, you must understand
how values are passed around, and what mutation means for those values.

Further Exploration

How can this feature of ruby get you in trouble? How can you avoid it?

For even more information on this topic, see these Blog posts:

    Variable References and Mutability of Ruby Objects
    Mutating and Non-Mutating Methods in Ruby
    Object Passing in Ruby - Pass by Reference or Pass by Value


Other Answers:

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2

=begin

So in the first #each method we initialize array2 with every element inside array1

and we used #<< method which means that every element inside array2 is a reference from the elements inside array1

In the second #each method we call the #upcase! method. While that method mutate the caller and returns self
the changes that has been made inside array1 will affect elements inside array2

and this code above will print:

Moe
Larry
CURLY
SHEMP
Harpo
CHICO
Groucho
Zeppo

# How can this feature of ruby get you in trouble? How can you avoid it?

Sometimes you'll find yourself affecting other objects without given intention to them
so to avoid those issues you can make a shallow copy to that object before making any changes

# For example we could make this :

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value.dup }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2

end


TO REVIEW: 
- Pass by Reference vs Pass by Value in Lesson 2 Programming Foundation
- 3 Blog posts
- ***And how array1.each { |value| array2 << value } does not create new String objects with
  the same value for array2 but is actually copying the references to the same String Objects
  in array1 to array2.***

=end

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2

puts ""
puts ""

array3 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array4 = []
array3.each { |value| array4 << value.dup }
array3.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array4