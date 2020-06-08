# Write a program called name.rb that asks the user to type in their name and
# then prints out a greeting message with their name included.
print "Please enter your name: "
name = gets.chomp
puts "Hello, #{name}!" 


# Write a program called age.rb that asks a user how old they are and then
# tells them how old they will be in 10, 20, 30 and 40 years. Below is the
# output for someone 20 years old.
print "Please enter your age: "
age = gets.chomp.to_i
puts "You will be #{age+10} in 10 years."
puts "You will be #{age+20} in 20 years."
puts "You will be #{age+30} in 30 years."
puts "You will be #{age+40} in 40 years."


# Add another section onto name.rb that prints the name of the user 10 times. 
# You must do this without explicitly writing the puts method 10 times in a row. 
# Hint: you can use the times method to do something repeatedly.
10.times {|i| puts "#{i+1} - #{name}" }


# Modify name.rb again so that it first asks the user for their first name, saves
# it into a variable, and then does the same for the last name. Then outputs their full name all at once.
print "What is your first name? "
first_name = gets.chomp.capitalize
print "What is your last name? "
last_name = gets.chomp.capitalize
puts "Hello, #{first_name} #{last_name}!"



=begin
Look at the following programs...

x = 0
3.times do
  x += 1
end
puts x

and...

y = 0
3.times do
  y += 1
  x = y
end
puts x

What does x print to the screen in each case? Do they both give errors? Are the errors different? Why?

Answer:
x prints 3 in first example but results in undefined local variable in second example. This is because x is a local variable within 
the do end block following times method invocation. When we try to access x after end, it is already out of scope.

scope.rb:51:in `<main>': undefined local variable or method `x' for main:Object
(NameError)
=end