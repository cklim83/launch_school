=begin

1) Write a program called name.rb that asks the user to type in their name and then prints out a greeting message with their name included.

=end

print "Please enter your name: "
name = gets.chomp.capitalize

puts "Hello " + name + '!'


=begin

2) Write a program called age.rb that asks a user how old they are and then tells them how old they will be in 10, 20, 30 and 40 years. 
Below is the output for someone 20 years old.

# output of age.rb for someone 20 yrs old

How old are you?
In 10 years you will be:
30
In 20 years you will be:
40
In 30 years you will be:
50
In 40 years you will be:
60

=end

puts "How old are you?"
age = gets.chomp.to_i

for i in 1..4 do
  puts "In #{i*10} years you will be:"
  puts age + (i*10)
end


=begin

3) Add another section onto name.rb that prints the name of the user 10 times. 
You must do this without explicitly writing the puts method 10 times in a row. 
Hint: you can use the times method to do something repeatedly.

=end

print "Please enter your name: "
name = gets.chomp.capitalize

10.times {puts "Hello, " + name + '!' } 


=begin

4) Modify name.rb again so that it first asks the user for their first name, saves it 
into a variable, and then does the same for the last name. Then outputs their full name all at once.

=end

puts "Please enter your first name: "
first_name = gets.chomp.capitalize
puts "Please enter your first name: "
last_name = gets.chomp.capitalize

puts "Hello #{first_name}, #{last_name}!"  


=begin

5) Look at the following programs...

x = 0
3.times do
  x += 1
end
puts x

y = 0
3.times do
  y += 1
  x = y
end
puts x

What does x print to the screen in each case? Do they both give errors? Are the errors different? Why?

=end

# In 1st case, it prints 3
# In 2nd case, it prints NameError, undefined local variable or method x since x is defined within the block and it is not accessible outside it.
