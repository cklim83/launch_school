=begin

1) Write down whether the following expressions return true or false. 
Then type the expressions into irb to see the results.

(32 * 4) >= 129                                                   false
false != !true                                                    false
true == 4                                                         false
false == (847 == '874')                                           true
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false       true

=end


=begin

2) Write a method that takes a string as an argument. 
The method should return a new, all-caps version of the string, 
only if the string is longer than 10 characters. 
Example: change "hello world" to "HELLO WORLD". 
(Hint: Ruby's String class has a few methods that would be helpful. Check the Ruby Docs!)

=end

def conditional_caps(phrase)
  if phrase.length > 10
    phrase.upcase
  else 
    phrase
  end
end


puts caps("Joe Smith")
puts caps("Joe Robertson")


=begin

3) Write a program that takes a number from the user between 0 and 100 
and reports back whether the number is between 0 and 50, 51 and 100, or above 100.

=end

print "Please enter a number between 0 and 100: "
num = gets.chomp.to_i

if num < 0
  puts "You entered a negative number!"
elsif num < 51
  puts "Number is between 0 and 50!"
elsif num <= 100
  puts "Number is between 51 and 100!"
else
  puts "Number is above 100"
end


=begin

4) What will each block of code below print to the screen? 
Write your answer on a piece of paper or in a text editor and 
then run each block of code to see if you were correct.

# Snippet 1
'4' == 4 ? puts("TRUE") : puts("FALSE")       "FALSE"

# Snippet 2
x = 2
if ((x * 3) / 2) == (4 + 4 - x - 3)           "Did you get it right?"
  puts "Did you get it right?"
else
  puts "Did you?"
end

# Snippet 3
y = 9                                         "Alight now!"
x = 10
if (x + 1) <= (y)
  puts "Alright."
elsif (x + 1) >= (y)
  puts "Alright now!"
elsif (y + 1) == x
  puts "ALRIGHT NOW!"
else
  puts "Alrighty!"
end

=end


=begin

5) When you run the following code...

def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
end

equal_to_four(5)

You get the following error message..
exercise.rb:8: syntax error, unexpected end-of-input, expecting keyword_end

Why do you get this error and how can you fix it?

# The method was missing an end keyword. Add an end keyword after puts "nope" with same indent as else statement.

=end


=begin

6) Write down whether the following expressions return true or false or raise an error. 
Then, type the expressions into irb to see the results.

(32 * 4) >= "129"     Error. Cannot use >= to compare different types
847 == '874'          False
'847' < '846'         False
'847' > '846'         True
'847' > '8478'        False. '8478' is longer, hence it is bigger
'847' < '8478'        True

=end