=begin
Write down whether the following expressions return true or false. Then type the expressions into irb to see the results.

(32 * 4) >= 129           => false
false != !true            => false
true == 4                 => false
false == (847 == '874')   => true
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false  => true (only 328 /4 == 4 is true)

=end


=begin
Write a method that takes a string as argument. The method should return a new, all-caps version of the string,
only if the string is longer than 10 characters. Example: change "hello world" to "HELLO WORLD". 
(Hint: Ruby's String class has a few methods that would be helpful. Check the Ruby Docs!)
=end

def caps_long_string(phrase)
  new_phrase = phrase.length > 10 ? phrase.upcase : phrase 
end

puts caps_long_string("This sentence should be cap!")
puts caps_long_string("Short!")


# Write a program that takes a number from the user between 0 and 100 and reports back whether the number is 
# between 0 and 50, 51 and 100, or above 100.

print "Please enter a number between 0 and 100: "
user_num = gets.chomp.to_i

def get_msg(user_num)
  if user_num>=0 && user_num<=50
    "Number is between 0 and 50"
  elsif user_num >=51 && user_num<=100
    "Number is between 51 and 100"
  elsif user_num > 100
    "Number is above 100"
  else
    "Number is none of above!"
  end
end

puts get_msg(user_num)


=begin
What will each block of code below print to the screen? Write your answer on a piece of paper or in a text 
editor and then run each block of code to see if you were correct.

# Snippet 1
'4' == 4 ? puts("TRUE") : puts("FALSE")   => "FALSE"

# Snippet 2
x = 2
if ((x * 3) / 2) == (4 + 4 - x - 3)       => "Did you get it right?"
  puts "Did you get it right?"
else
  puts "Did you?"
end

# Snippet 3
y = 9
x = 10
if (x + 1) <= (y)                       => "Alright now!"
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
When you run the following code...

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

Answer:
the if construct is not properly closed with an end. Instead the end is matched to the if statement. To fix this, add an end after puts "nope"

=end