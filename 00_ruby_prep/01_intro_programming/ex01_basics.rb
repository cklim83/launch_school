=begin

1) Add two strings together that, when concatenated, return your first and last name 
as your full name in one string.

=end

"CK" + "Lim"    # Concatenate with + operator
"CK" << "Lim"  # Concatenate with << operator


=begin

2) Use the modulo operator, division, or a combination of both to take a 4 digit number 
and find the digit in the: 1) thousands place 2) hundreds place 3) tens place 4) ones place

=end

number = 6273
thousands = (number % 10000) / 1000
hundreds = (number % 1000) / 100
tens = (number % 100) / 10
ones = (number % 10)


=begin
3) Write a program that uses a hash to store a list of movie titles with the year they came out. 
Then use the puts command to make your program print out the year of each movie to the screen. 
The output for your program should look something like this.

1975
2004
2013
2001
1981

=end

movies = {
  jaws: 1975,
  anchorman: 2004,
  man_of_steel: 2013,
  a_beautiful_mind: 2001,
  the_evil_dead: 1981 
}

puts movies[:jaws]
puts movies[:anchorman]
puts movies[:man_of_steel]
puts movies[:a_beautiful_mind]
puts movies[:the_evil_dead]


=begin

4) Use the dates from the previous example and store them in an array. Then make your program output the same thing as exercise 3.

=end

movie_dates = [1975, 2004, 2013, 2001, 1981]

puts movie_dates[0]
puts movie_dates[1]
puts movie_dates[2]
puts movie_dates[3]
puts movie_dates[4]


=begin

5) Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

=end

puts 5*4*3*2*1
puts 6*5*4*3*2*1
puts 7*6*5*4*3*2*1
puts 8*7*6*5*4*3*2*1


=begin

6) Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen.

=end

puts 3.14**2
puts 92.412**2
puts (-1748.2452)**2


=begin

7) What does the following error message tell you?

SyntaxError: (irb):2: syntax error, unexpected ')', expecting '}'
  from /usr/local/rvm/rubies/ruby-2.5.3/bin/irb:16:in `<main>'

=end

# Program is expecting a closing curly brace } likely for a hash but got a ) instead


