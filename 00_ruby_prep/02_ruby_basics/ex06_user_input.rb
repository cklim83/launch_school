=begin

1) Write a program that asks the user to type something in, 
after which your program should simply display what was entered.

$ ruby repeater.rb
>> Type anything you want:
This is what I typed.
This is what I typed.

=end

puts ">> Type anything you want:"
input = gets.chomp
puts input


=begin

2) Write a program that asks the user for their age in years, 
and then converts that age to months.

$ ruby age.rb
>> What is your age in years?
35
You are 420 months old.

=end

puts ">> What is your age in years?"
age_years = gets.chomp.to_i
puts "You are #{age_years * 12} months old."


=begin

3) Write a program that asks the user whether they want the 
program to print "something", then print it if the user enters y. 
Otherwise, print nothing.

$ ruby something.rb
>> Do you want me to print something? (y/n)
y
something

$ ruby something.rb
>> Do you want me to print something? (y/n)
n

$ ruby something.rb
>> Do you want me to print something? (y/n)
help

=end

puts ">> Do you want me to print something? (y/n)"
choice = gets.chomp
puts "something" if choice == 'y'


=begin

4) In the previous exercise, you wrote a program that asks the user 
if they want the program to print "something". However, this program 
recognized any input as valid: if you answered anything but y, it 
treated it as an n response, and quit without printing anything.

Modify your program so it prints an error message for any inputs 
that aren't y or n, and then asks you to try again. Keep asking 
for a response until you receive a valid y or n response. In 
addition, your program should allow both Y and N (uppercase) 
responses; case sensitive input is generally a poor user interface
choice. Whenever possible, accept both uppercase and lowercase inputs.

$ ruby something2.rb
>> Do you want me to print something? (y/n)
y
something

$ ruby something2.rb
>> Do you want me to print something? (y/n)
help
>> Invalid input! Please enter y or n
>> Do you want me to print something? (y/n)
Y
something

$ ruby something2.rb
>> Do you want me to print something? (y/n)
N

$ ruby something2.rb
>> Do you want me to print something? (y/n)
NO
>> Invalid input! Please enter y or n
>> Do you want me to print something? (y/n)
n

=end

loop do
  puts ">> Do you want me to print something? (y/n)"
  choice = gets.chomp.downcase

  case choice
    when "y" then puts "something"
    when "n" then break
    else puts "Invalid input! Please enter y or n" 
  end
end


=begin

5) Write a program that prints 'Launch School is the best!' 
repeatedly until a certain number of lines have been printed. 
The program should obtain the number of lines from the user, 
and should insist that at least 3 lines are printed.

For now, just use #to_i to convert the input value to an Integer, 
and check that result instead of trying to insist on a valid number; 
validation of numeric input is a topic with a fair number of edge 
conditions that are beyond the scope of this exercise.

$ ruby lsprint.rb
>> How many output lines do you want? Enter a number >= 3:
5
Launch School is the best!
Launch School is the best!
Launch School is the best!
Launch School is the best!
Launch School is the best!

$ ruby lsprint.rb
>> How many output lines do you want? Enter a number >= 3:
2
>> That's not enough lines.
>> How many output lines do you want? Enter a number >= 3:
3
Launch School is the best!
Launch School is the best!
Launch School is the best!

=end

num_reps = nil
loop do
  puts ">> How many output lines do you want? Enter a number >= 3:"
  num_reps = gets.chomp.to_i
  break if num_reps >= 3
  puts ">> That's not enough lines."
end

num_reps.times { puts "Launch School is the best!"}


=begin

6) Write a program that displays a welcome message, but only after 
the user enters the correct password, where the password is a 
string that is defined as a constant in your program. Keep asking 
for the password until the user enters the correct password.

$ ruby password.rb
>> Please enter your password:
Hello
>> Invalid password!
>> Please enter your password:
Secret
>> Invalid password!
>> Please enter your password:
SecreT
Welcome!

=end

PASSWORD = "SecreT"

loop do
  puts ">> Please enter your password:"
  submitted_password = gets.chomp
  break if submitted_password == PASSWORD
  puts ">> Invalid password!"
end

puts" Welcome!"


=begin

7) In the previous exercise, you wrote a program to solicit a password. 
In this exercise, you should modify the program so it also requires a 
user name. The program should solicit both the user name and the password, 
then validate both, and issue a generic error message if one or both are 
incorrect; the error message should not tell the user which item is incorrect.

$ ruby login.rb
>> Please enter user name:
John
>> Please enter your password:
Hello
>> Authorization failed!
>> Please enter user name:
mary
>> Please enter your password:
SecreT
>> Authorization failed!
>> Please enter user name:
admin
>> Please enter your password:
root
>> Authorization failed!
>> Please enter user name:
admin
>> Please enter your password:
SecreT
Welcome!

=end

USERNAME = "admin"
PASSWORD = "SecreT"

loop do
  puts ">> Please enter user name:"
  submitted_username = gets.chomp
  
  puts ">> Please enter your password:"
  submitted_password = gets.chomp
  
  break if submitted_username == USERNAME && submitted_password == PASSWORD
  puts ">> Authorization failed!"
  
end

puts "Welcome!"


=begin

8) Write a program that asks the user to enter two integers, then prints the results 
of dividing the first by the second. The second number must not be 0. Since this is 
user input, there's a good chance that the user won't enter a valid integer. Therefore, 
you must validate the input to be sure it is an integer. You can use the following code 
to determine whether the input is an integer:

def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end

It returns true if the input string can be converted to an integer and back to a string 
without loss of information, false otherwise. It's not a perfect solution in that some 
inputs that are otherwise valid (such as 003) will fail, but it is sufficient for this 
exercise.

$ ruby division.rb
>> Please enter the numerator:
8
>> Please enter the denominator:
2
>> 8 / 2 is 4

$ ruby division.rb
>> Please enter the numerator:
8.3
>> Invalid input. Only integers are allowed.
>> Please enter the numerator:
9
>> Please enter the denominator:
4
>> 9 / 4 is 2


$ ruby division.rb
>> Please enter the numerator:
10
>> Please enter the denominator:
a
>> Invalid input. Only integers are allowed.
>> Please enter the denominator:
0
>> Invalid input. A denominator of 0 is not allowed.
>> Please enter the denominator:
5
>> 10 / 5 is 2

=end

def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end

numerator_string = nil

loop do
  puts ">> Please enter the numerator:"
  numerator_string = gets.chomp
  
  break if valid_number?(numerator_string)
  puts ">> Invalid input. Only integers are allowed."
end

denominator_string = nil

loop do
  puts ">> Please enter the denominator:"
  denominator_string = gets.chomp
   
  break if denominator_string != '0' && valid_number?(denominator_string)
   
  puts ">> Invalid input. Only integers are allowed." unless valid_number?(denominator_string)
  puts ">> Invalid input. A denominator of 0 is not allowed." unless denominator_string != '0'
end

numerator = numerator_string.to_i
denominator = denominator_string.to_i
result = numerator / denominator

puts ">> #{numerator} / #{denominator} is #{result}"


=begin

9) In an earlier exercise, you wrote a program that prints 'Launch School is the best!' 
repeatedly until a certain number of lines have been printed. Our solution looked like this:

number_of_lines = nil
loop do
  puts '>> How many output lines do you want? Enter a number >= 3:'
  number_of_lines = gets.to_i
  break if number_of_lines >= 3
  puts ">> That's not enough lines."
end

while number_of_lines > 0
  puts 'Launch School is the best!'
  number_of_lines -= 1
end

Modify this program so it repeats itself after each input/print iteration, asking for 
a new number each time through. The program should keep running until the user enters q or Q.

Sample output

$ ruby lsprint2.rb
>> How many output lines do you want? Enter a number >= 3 (Q to quit):
5
Launch School is the best!
Launch School is the best!
Launch School is the best!
Launch School is the best!
Launch School is the best!
>> How many output lines do you want? Enter a number >= 3 (Q to quit):
2
>> That's not enough lines.
>> How many output lines do you want? Enter a number >= 3 (Q to quit):
3
Launch School is the best!
Launch School is the best!
Launch School is the best!
>> How many output lines do you want? Enter a number >= 3 (Q to quit):
q

=end

number_of_lines = nil

def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end

loop do
  puts '>> How many output lines do you want? Enter a number >= 3: (Q to quit)'
  number_of_lines = gets.chomp
  
  if %w(q Q).include?(number_of_lines)
    break
  
  elsif valid_number?(number_of_lines)
    
    number_of_lines = number_of_lines.to_i
    
    if number_of_lines >= 3
      number_of_lines.times { puts 'Launch School is the best!' }
    else
      puts ">> That's not enough lines."
    end
 
  else
    puts "You entered an invalid character!"
  end
end


=begin

10) Write a program that requests two integers from the user, adds them together, 
and then displays the result. Furthermore, insist that one of the integers be positive, 
and one negative; however, the order in which the two integers are entered does not matter.

Do not check for the positive/negative requirement until both integers are entered, and 
start over if the requirement is not met.

You may use the following method to validate input integers:

def valid_number?(number_string)
  number_string.to_i.to_s == number_string && number_string.to_i != 0
end


Examples

$ ruby opposites.rb
>> Please enter a positive or negative integer:
8
>> Please enter a positive or negative integer:
0
>> Invalid input. Only non-zero integers are allowed.
>> Please enter a positive or negative integer:
-5
8 + -5 = 3

$ ruby opposites.rb
>> Please enter a positive or negative integer:
8
>> Please enter a positive or negative integer:
5
>> Sorry. One integer must be positive, one must be negative.
>> Please start over.
>> Please enter a positive or negative integer:
-7
>> Please enter a positive or negative integer:
5
-7 + 5 = -2

=end

def valid_number?(number_string)
  number_string.to_i.to_s == number_string && number_string.to_i != 0
end

def get_number
  loop do
    puts ">> Please enter a positive or negative integer:"
    number = gets.chomp
    return number.to_i if valid_number?(number)
    puts ">> Invalid input. Only non-zero integers are allowed."
  end
end

first_num = nil
second_num = nil

loop do
  first_num = get_number
  second_num = get_number
  break if first_num * second_num < 0  # Numbers are not opposite in sign
  puts ">> Sorry. One integer must be positive, one must be negative."
  puts ">> Please start over."
end

sum = first_num + second_num
puts "#{first_num} + #{second_num} =  #{sum}"
