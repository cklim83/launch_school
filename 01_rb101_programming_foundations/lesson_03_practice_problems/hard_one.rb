=begin
Question 1

What do you expect to happen when the greeting variable is referenced in the last line of the code below?

if false
  greeting = "hello world"
end

greeting

My answer:
Not sure. Considerations:
- if statement do not establish a separate scope, so variables initialized within it is can be accessed after it
- However, the initialization is not really executed as the conditional for this branch is false.
- Nonetheless i remember even if the branch is not executed, some sort of initialization had taken place.
- Hence i guess greeting will have been given a nil value.


Given answer:
greeting is nil here, and no "undefined method or local variable" exception is thrown. 
Typically, when you reference an uninitialized variable, Ruby will raise an exception, stating that it’s undefined.
However, when you initialize a local variable within an if block, even if that if block doesn’t get executed, 
the local variable is initialized to nil.

=end

if false
  greeting = "hello world"
end

puts greeting.inspect


=begin
Question 2

What is the result of the last line in the code below?

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings


My answer:
puts greetings will output { a: "hi there" }. 
informal_greeting and greetings[:a] both reference the same object after assigning the latter to the former
The << operator modified the object that informal_greeting in-place, which is also the object greeting[:a] is referencing.
Hence greetings hash is also affected.

Given answer:


The output is {:a=>"hi there"}. The reason is because informal_greeting is a reference to the original object. 
The line informal_greeting << ' there' was using the String#<< method, which modifies the object that called it. 
This means that the original object was changed, thereby impacting the value in greetings. If instead of modifying
the original object, we wanted to only modify informal_greeting but not greetings, there are a couple of options:

  we could initialize informal_greeting with a reference to a new object containing the same value by 
    informal_greeting = greetings[:a].clone.
  
  we can use string concatenation, informal_greeting = informal_greeting + ' there', 
  which returns a new String object instead of modifying the original object.


TO REVIEW:
hash is represented using the hash rocket even though we use the new syntax
{ a: "hi there" } is still stored as {:a=>"hi there"} in memory

=end


=begin
Question 3

In other practice problems, we have looked at how the scope of variables affects the modification of one "layer" when they are passed to another.

To drive home the salient aspects of variable scope and modification of one scope by another, consider the following similar sets of code.

What will be printed by each of these code groups?

A)

def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

My answer:
one is: one
two is: two
three is: three

mess_with_vars is a non-mutating method. All the expressions within involves reassignments of method variables without impacting
the original objects that they reference.

Given answer:
"one is: one"
"two is: two"
"three is: three"

B)

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"


My answer:
one is: one
two is: two
three is: three

mess_with_vars is a non-mutating method. All the expressions within involves reassignments of method variables without impacting
the original objects that they reference.

Given answer:
"one is: one"
"two is: two"
"three is: three"

C)

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

My answer:
one is: two
two is: three
three is: one

mess_with_vars is a mutating method. All the expressions utilises methods that changes the objects they reference in place.

Given answer:
"one is: two"
"two is: three"
"three is: one"

=end


=begin

Question 4

Ben was tasked to write a simple ruby method to determine if an input string is an IP address representing 
dot-separated numbers. e.g. "10.4.5.11". He is not familiar with regular expressions. Alyssa supplied Ben
with a method called is_an_ip_number? that determines if a string is a numeric string between 0 and 255
as required for IP numbers and asked Ben to use it.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end

Alyssa reviewed Ben's code and says "It's a good start, but you missed a few things. You're not returning
a false condition, and you're not handling the case that there are more or fewer than 4 components to the
IP address (e.g. "4.5.5" or "1.2.3.4.5" should be invalid)."

Help Ben fix his code.

My answer:
See below


Given answer:
There are several ways to fix this. To determine if there are exactly 4 dot-separated "words" in the 
string, you can simply add a check for dot_separated_words.size after splitting the string.

The other error in Ben's code is that instead of returning false upon encountering a non-numeric component, 
he used break to break out of the while loop. Once he breaks, control falls through to the return true statement.
He can fix this by performing return false instead of break.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end

  true
end

Note: Ben's original return true on the last line of the method can be shortened to just true. 
This is because Ruby returns the result of the last evaluated expression.

TO REVIEW:
Use do_something unless conditional == instead of do_something if conditional !=
Remove redundant code like return true in this instance

=end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4 
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  
  return true
end