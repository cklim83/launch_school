=begin
Question 1

Every named entity in Ruby has an object_id. This is a unique identifier for that object.

It is often the case that two different things "look the same", but they can be different objects. The "under the hood" object 
referred to by a particular named-variable can change depending on what is done to that named-variable.

In other words, in Ruby, all values are objects...but they are not always the same object.

Predict how the values and object ids will change throughout the flow of the code below:

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts

    a_outer = 22
    b_outer = "thirty three"
    c_outer = [44]
    d_outer = c_outer[0]

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts


    a_inner = a_outer
    b_inner = b_outer
    c_inner = c_outer
    d_inner = c_inner[0]

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end

My answer:

"a_outer is 42 with an id of: 10 before the block."
"b_outer is forty two with an id of: 10000 before the block."
"c_outer is [42] with an id of: 20000 before the block."
"d_outer is 42 with an id of: 20 before the block."

"a_outer id was 10 before the block and is: 10 inside the block."
"b_outer id was 10000 before the block and is: 10000 inside the block."
"c_outer id was 20000 before the block and is: 20000 inside the block."
"d_outer id was 20 before the block and is: 20 inside the block."

"a_outer inside after reassignment is 22 with an id of: 10 before and: 30 after."
"b_outer inside after reassignment is thirty three with an id of: 10000 before and: 30000 after."
"c_outer inside after reassignment is [44] with an id of: 20000 before and: 40000 after."
"d_outer inside after reassignment is 44 with an id of: 20 before and: 40 after."

"a_inner is 22 with an id of: 30 inside the block (compared to 30 for outer)."
"b_inner is thirty three with an id of: 30000 inside the block (compared to 30000 for outer)."
"c_inner is [44] with an id of: 40000 inside the block (compared to 40000 for outer)."
"d_inner is 44 with an id of: 40 inside the block (compared to 40 for outer)."

"a_outer is 22 with an id of: 10 BEFORE and: 30 AFTER the block."
"b_outer is thirty three with an id of: 10000 BEFORE and: 30000 AFTER the block."
"c_outer is [44] with an id of: 20000 BEFORE and: 40000 AFTER the block."
"d_outer is 44 with an id of: 20 BEFORE and: 40 AFTER the block."

"ugh ohhhhh"  (Because variables defined inside a block is not accessible outside of it)
"ugh ohhhhh"  (Because variables defined inside a block is not accessible outside of it)
"ugh ohhhhh"  (Because variables defined inside a block is not accessible outside of it)
"ugh ohhhhh"  (Because variables defined inside a block is not accessible outside of it)


Given answer:
a_outer is 42 with an id of: 85 before the block.
b_outer is forty two with an id of: 2152729580 before the block.
c_outer is [42] with an id of: 2152729540 before the block.
d_outer is 42 with an id of: 85 before the block.

Notice that Ruby re-used the "42 object with id 85" when the value was the same.


a_outer id was 85 before the block and is: 85 inside the block.
b_outer id was 2152729580 before the block and is: 2152729580 inside the block.
c_outer id was 2152729540 before the block and is: 2152729540 inside the block.
d_outer id was 85 before the block and is: 85 inside the block.

Notice that Ruby did NOT change the id for any of the objects between outside and inside the block


a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
b_outer inside after reassignment is thirty three with an id of: 2152729580 before and: 2152728320 after.
c_outer inside after reassignment is [44] with an id of: 2152729540 before and: 2152728280 after.
d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

Notice that changing the values has forced Ruby to create new objects and refer to them with the original variable names.


a_inner is 22 with an id of: 45 inside the block (compared to 45 for outer).
b_inner is thirty three with an id of: 2152728320 inside the block (compared to 2152728320 for outer).
c_inner is [44] with an id of: 2152728280 inside the block (compared to 2152728280 for outer).
d_inner is 44 with an id of: 89 inside the block (compared to 89 for outer).

Notice that Ruby re-uses the objects under the hood when it can, but uses different ones for different values.


a_outer is 22 with an id of: 85 BEFORE and: 45 AFTER the block.
b_outer is thirty three with an id of: 2152729580 BEFORE and: 2152728320 AFTER the block.
c_outer is [44] with an id of: 2152729540 BEFORE and: 2152728280 AFTER the block.
d_outer is 44 with an id of: 85 BEFORE and: 89 AFTER the block.
(notice that each variable keeps its new object/object_id even when we leave the block.)


 => "ugh ohhhhh"
 
TO REVIEW: 
KNOWLEDGE GAP: When both variables have same value and Ruby reusing the same object so that they both have same object id.
Quick test on irb show that for the reuse of objects works for Integer, Float, Nil, Boolean but not for String. I suspect 
immutable objects have fixed object ids that is shared. Mutables meanwhile will have dynamic object_ids.

2.6.3 :001 > a=42
 => 42 
2.6.3 :002 > b=42
 => 42 
2.6.3 :003 > a.object_id
 => 85 
2.6.3 :004 > b.object_id
 => 85 
2.6.3 :005 > a="hello"
 => "hello" 
2.6.3 :006 > b="hello"
 => "hello" 
2.6.3 :007 > a.object_id 
 => 21424540 
2.6.3 :008 > b.object_id
 => 21443780 
 
Other Concepts: 
- Complex types like Strings or Arrays have longer object ids. 
- local variables defined before a block is accessible within that block. They are still pointing to the same objects when inside the block 
  Note: Concept of shadowing doesnt apply here as the block doesnt have block variables with same name as local variables such that 
  it masks their effects.
- Reassignment of variables cause them to point to new objects, hence their object ids are changed after reassignment
- Local variables retain the changes made in the block when they exits the block
- Local variables first initialized within the block is out of scope when the block exits. 
 
=end

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts

    a_outer = 22
    b_outer = "thirty three"
    c_outer = [44]
    d_outer = c_outer[0]

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts


    a_inner = a_outer
    b_inner = b_outer
    c_inner = c_outer
    d_inner = c_inner[0]

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end

fun_with_ids


=begin
Question 2

Let's look at object id's again from the perspective of a method call instead of a block.

Here we haven't changed ANY of the code outside or inside of the block/method. We simply took the contents of the block 
from the previous practice problem and moved it to a method, to which we are passing all of our outer variables.

Predict how the values and object ids will change throughout the flow of the code below:

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)


  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call."
  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts
end


def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)

  puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method."
  puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method."
  puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method."
  puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method."
  puts

  a_outer = 22
  b_outer = "thirty three"
  c_outer = [44]
  d_outer = c_outer[0]

  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
  puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
  puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
  puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
  puts

  a_inner = a_outer
  b_inner = b_outer
  c_inner = c_outer
  d_inner = c_inner[0]

  a_inner_id = a_inner.object_id
  b_inner_id = b_inner.object_id
  c_inner_id = c_inner.object_id
  d_inner_id = d_inner.object_id

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer)."
  puts
end


My answer:
"a_outer is 42 with an id of: 85 before the block."
"b_outer is forty two with an id of: 7442560 before the block."
"c_outer is [42] with an id of: 7442540 before the block."
"d_outer is 42 with an id of: 85 before the block."

"a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call."
"b_outer is forty two with an id of: 7442560 BEFORE and: 7442560 AFTER the method call."
"c_outer is [42] with an id of: 7442540 BEFORE and: 7442540 AFTER the method call."
"d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call."

"a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after."
"b_outer inside after reassignment is thirty three with an id of: 7442560 before and: 7442860 after."
"c_outer inside after reassignment is [44] with an id of: 7442540 before and: 744350 after."
"d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after."

"a_inner is 22 with an id of: 45 inside the method (compared to 45 for outer)."
"b_inner is thirty three with an id of: 7442860 inside the method (compared to 7442860 for outer)."
"c_inner is [44] with an id of: 744350 inside the method (compared to 744350 for outer)."
"d_inner is 44 with an id of: 89 inside the method (compared to 89 for outer)."

"a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call."
"b_outer is forty two with an id of: 7442560 BEFORE and: 7442560 AFTER the method call."
"c_outer is [42] with an id of: 7442540 BEFORE and: 7442540 AFTER the method call."
"d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call."

"ugh ohhhhh"
"ugh ohhhhh"
"ugh ohhhhh"
"ugh ohhhhh"


Given answer:

a_outer is 42 with an id of: 85 before the block.
b_outer is forty two with an id of: 2152753560 before the block.
c_outer is [42] with an id of: 2152753540 before the block.
d_outer is 42 with an id of: 85 before the block.

Notice that this works the same as before. No big surprise.


a_outer id was 85 before the method and is: 85 inside the method.
b_outer id was 2152753560 before the method and is: 2152753560 inside the method.
c_outer id was 2152753540 before the method and is: 2152753540 inside the method.
d_outer id was 85 before the method and is: 85 inside the method.

This is also the same as before. These "outers" are NOT the same variables as those outside, 
Ruby is simply re-using the objects, as these new variables have the same values as the ones outside.


a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
b_outer inside after reassignment is thirty three with an id of: 2152753560 before and: 2152752300 after.
c_outer inside after reassignment is [44] with an id of: 2152753540 before and: 2152752280 after.
d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

As before with the block version of this practice problem, when we change the values of our "outers", 
Ruby uses new objects for these variables to deal with their new values.

One important difference to note is that before, we saw Ruby re-using the "42" object and just giving it
a new value inside the block. Why the difference? It should become clear a couple of paragraphs later in this solution...


a_inner is 22 with an id of: 45 inside the method (compared to 45 for outer).
b_inner is thirty three with an id of: 2152752300 inside the method (compared to 2152752300 for outer).
c_inner is [44] with an id of: 2152752280 inside the method (compared to 2152752280 for outer).
d_inner is 44 with an id of: 89 inside the method (compared to 89 for outer).

No big surprise here...Ruby is re-using objects that have the same values...


a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.
b_outer is forty two with an id of: 2152753560 BEFORE and: 2152753560 AFTER the method call.
c_outer is [42] with an id of: 2152753540 BEFORE and: 2152753540 AFTER the method call.
d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.

Wow, look at that. Even though we changed the values of our "outer" variables inside the method call, we still
have the same values and the same object id's down here AFTER the method call as we had before it!

This is because our method call accepts VALUES as arguments. The names we give to those values in the definition
of our method are SEPARATE from any other use of those same names.

We used the same names there for convenience (and admittedly to build some suspense and allow us to clarify this
point). We could just as easily have called the first parameter of our method definition a_Fred instead of a_outer.

The method gets the VALUES of the arguments we pass, but the parameter variables inside the method have no other
relationship to those outside of the method. The names were coincidental, and confusing in a useful way.

=> "ugh ohhhhh"

Our main method STILL has no access to variables that are defined inside of the method.


TO REVIEW
Concepts:
- When we pass arguments to a method, the parameters of that methods are simply pointing to the values of those arguments
- Regardless whether the parameters of the method use the same names as the arguments in the caller, but they are actually different pointers.
- Whether the method mutates the arguments passed into it depends on two things
  a) whether the object is mutable e.g. strings, array etc
  b) whether the changes in the method can the object in place (e.g. Hash#[]=) or simply involves a reassignment, pointing the method variable to a new object
  and doesnt change the original object.
  
  method(variable_1)
  
  def method(variable_1)
    ...
  end
  
  The variable_1 in the invokation is DIFFERENT from the variable_1 in the method. It just that they both reference to the same value 
  during the call. The parameter in method can be named variable_2 and everything remains the same, just less confusing.

=end


=begin
Question 3

Let's call a method, and pass both a string and an array as arguments and see how even 
though they are treated in the same way by Ruby, the results can be different.

Study the following code and state what will be displayed...and why:

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

My answer:
My string looks like this now: pumpkins
My array looks like this now: ["pumpkins", "rutabaga"]

Inside tricky_method, the operation on the string parameter is non-mutating and simply pointed the method parameter
a_string_param to a new object containing a copy of "pumpkins" concatenated with "rutabaga". However the original 
object that my_string is pointing to is still unchanges and continue to be "pumpkins". 
The operation on the array object is however mutating and appends the array object directly. Hence when the method returns,
the array now has 2 elements.


Given answer:
Our output will look like this:

My string looks like this now: pumpkins
My array looks like this now: ["pumpkins", "rutabaga"]

Why? It seems clear from the above that Ruby treats string and array arguments differently...but not so fast. 
Actually the arguments are treated in exactly the same way...but the results are different.

In both cases, Ruby passes the arguments "by value", but unlike some other languages, the value that gets passed
is a reference to some object. The string argument is passed to the method as a reference to an object of type String.
Similarly, the array is passed to the method as a reference to an object of type Array.

The important distinction is that while a reference is passed, the method initializes a new local variable for both
the string and the array and assigns each reference to the new local variables. These are variables that only live
within the scope of the method definition.

So, if both arguments live inside the method as a new variable that stores a reference to the passed object...why don't
the string and the array behave the same way in our output?

The difference lies in what Ruby does when the program executes either a String#+= operation or an Array#<< operation.

The String#+= operation is re-assignment and creates a new String object. The reference to this new object is assigned
to a_string_param. The local variable a_string_param now points to "pumpkinsrutabaga", not "pumpkins". It has been 
re-assigned by the String#+= operation. This means that a_string_param and my_string no longer point to the same object.

With the array, one array object can have any number of elements. When we attach an additional element to an array
using the << operator, Ruby simply keeps using the same object that was passed in, and appends the new element to it.

So, because the local variable an_array_param still points to the original object, the local variables my_array and 
an_array_param are still pointing at the same object, and we see the results of what happened to the array "outside" 
of the method.

=end


=begin
Question 4

To drive that last one home...let's turn the tables and have the string show a modified output, while the array
thwarts the method's efforts to modify the caller's version of it.

def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"


My answer:
My string looks like this now: pumpkinsrutabaga
My array looks like this now: ["pumpkins"]

At the start of method call, a_string_param is assigned to point to the object "pumpkins" that local variable my_string is
pointing. The << operator, however concatenate "rutabaga" to very string object itself, changing the value of the string object 
that both variables are pointing. Thus, when the method returns and the scope of a_string_params end, my_string still registers
the change as the object it has been pointing to was changed in method call.

What happened to the array was different. At start of method call, an_array_param was pointing to the same object as my_array.
However, it was subsequently reassignment to point to a new array containing ['pumpkins', 'rutabaga'] but my_array was still
pointing to ['pumpkins']. Thus when the method returns, the array remains unchanged.


Given answer:
My string looks like this now: pumpkinsrutabaga
My array looks like this now: ["pumpkins"]

As you can see, we have achieved the opposite effect from our last example.

We are still passing in the same two string and array arguments, but the results are the opposite, because our method
does the "same thing" to each, but in a different way than before. That is, in both cases, the method attempts to
change the string from "pumpkins" to "pumpkinsrutabaga" and add "rutabaga" to the array.

Despite the similarity of the results inside the method definition, the results outside the method definition are the opposite.

As before, the explanation is all about what Ruby does with local variables when we change the object it points to. Does
it create a new local variable? Or is it able to just modify the existing object?

With the Array#= assignment, our literal ['pumpkins', 'rutabaga'] array is a new object, and we are assigning it to the
local variable an_array_param.

=end


=begin
Question 5

Depending on a method to modify its arguments can be tricky:

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

Whether the above "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.

How can we change this code to make the result easier to predict and easier for the next programmer to maintain?

My answer:
Depending on code intent, we can make this method to have no side-effects and non-mutating to both arguments and
use return values to communicate the change instead.

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]
  return a_string_param, an_array_param
end

changed_string, changed_array = tricky_method("abc", ["abc"])

Alternatively, if the intent is to mutate the caller in-place, we could follow method naming convention and 
append a ! to the method name, while also ensuring the string is mutated in-place too.

def tricky_method!(a_string_param, an_array_param)
  a_string_param << "rutabaga"
  an_array_param << "rutabaga"
end


Given answer:

def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

Every language (Ruby included) provides ways and means of writing "clever" code that depends on
some of the less obvious traits of the language.

Every good programmer practices these tricks...and then avoids them like the plague.

Clever programmers don't write "clever" code. They write explicit code that is easy to read,
debug and modify as the requirements change.

=end


=begin
Question 6

How could the following method be simplified without changing its return value?

def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end


My answer:

def color_valid(color)
  color == "blue" || color == "green"
end

The condition by itself will evaluate to either true or false. Hence an if, else construct is redundant.


Given answer:

Ruby will automatically evaluate statements, so this method:

def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end

Can be significantly simplified by changing it to just:

def color_valid(color)
  color == "blue" || color == "green"
end

Both of these methods do exactly the same thing - but one is much more complex to read.

=end
