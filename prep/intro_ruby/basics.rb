# Add two strings together that, when concatenated, return your first and last name as your full name in one string.
puts "Chee Kiang, " + "Lim"

# Use the modulo operator, division, or a combination of both to take a 4 digit number and find the digit in the: 
# 1) thousands place 2) hundreds place 3) tens place 4) ones place
number = 9374
thousands = number / 1000
hundreds = (number / 100) % 10
tens = (number / 10) % 10
ones = number % 10
puts "number: #{number}"
puts "thousands: #{thousands}"
puts "hundreds: #{hundreds}"
puts "tens: #{tens}"
puts "ones: #{ones}"


# Write a program that uses a hash to store a list of movie titles with the year they came out. Then use the puts 
# command to make your program print out the year of each movie to the screen. The output for your program should 
# look something like this.

movies = {"avatar 2" => 2021, "joker" => 2019, "frozen" => 2013}
puts movies["avatar 2"]
puts movies["joker"]
puts movies["frozen"]


# Use the dates from the previous example and store them in an array. Then make your program output the same thing 
# as exercise 3.
movie_years = [2021, 2019, 2013]
puts movie_years[0]
puts movie_years[1]
puts movie_years[2]


# Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.
five_factorial = 5 * 4 * 3 * 2
puts five_factorial
puts 6 * five_factorial
puts 7 * 6 * five_factorial
puts 8 * 7 * 6 * five_factorial


# Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen.
puts 10.0 ** 2
puts 4.5 ** 2
puts (-23.43) ** 2


=begin
What does the following error message tell you?

SyntaxError: (irb):2: syntax error, unexpected ')', expecting '}'
  from /usr/local/rvm/rubies/ruby-2.5.3/bin/irb:16:in `<main>'
  
Answer: The program was expecting a } but received a ) instead. Could be due to an unclosed hash
=end
