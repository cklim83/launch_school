# Write a program that prints a greeting message. This program should contain a method 
# called greeting that takes a name as its parameter and returns a string.

def greeting(name)
  "hello, " + name
end 

puts greeting("John")


=begin
What do the following expressions evaluate to?

1. x = 2                => 2

2. puts x = 2           => nil

3. p name = "Joe"       => "Joe"

4. four = "four"        => "four"

5. print something = "nothing"  => nil


=end


# Write a program that includes a method called multiply that takes two arguments and returns the product of the two numbers.

def multiply(first_num, second_num)
  first_num * second_num
end

puts multiply(3, 2)


=begin
What will the following code print to the screen?

def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee")

Answer: It will print nothing to screen as scream function returns before the put expression!

=end


# 1) Edit the method definition in exercise #4 so that it does print words on the screen. 2) What does it return now?
def scream(words)
  words = words + "!!!!"
  puts words
end

scream("Yippeee")

# Answer: It will return nil


=begin
What does the following error message tell you?

ArgumentError: wrong number of arguments (1 for 2)
  from (irb):1:in `calculate_product'
  from (irb):4
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
  
Answer: Wrong number of arguments supplied to calculate_product method. Method expects 2 arguments but only 1 is givem
=end
