=begin

1) Write a program that prints a greeting message. This program should contain a method 
called greeting that takes a name as its parameter and returns a string.

=end

def greeting(name)
  "Hello, " + name
end

puts greeting('CK')


=begin

2) What do the following expressions evaluate to?

1. x = 2                        returns 2

2. puts x = 2                   returns nil

3. p name = "Joe"               returns "Joe"

4. four = "four"                returns "four"

5. print something = "nothing"  returns nil

=end


=begin

3) Write a program that includes a method called multiply that takes two arguments and returns the product of the two numbers.

=end

def multiply(a, b)
  a * b
end

puts multiply(3, 10)


=begin

4) What will the following code print to the screen?

def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee")

=end

# It will print nothing since scream returns nil. puts words in scream is also not executed since it is after return.


=begin

5) ) Edit the method definition in exercise #4 so that it does print words on the screen. 2) What does it return now?

=end

def scream(words)
  words = words + "!!!!"
  puts words
end

scream("Yippeee")
# Will print Yippeee!!!! It still returns nil from the puts call. 


=begin

6) What does the following error message tell you?

ArgumentError: wrong number of arguments (1 for 2)
  from (irb):1:in `calculate_product'
  from (irb):4
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
  
=end

# We called a method called calculate_products with 1 argument when the method definition was expecting 2.
