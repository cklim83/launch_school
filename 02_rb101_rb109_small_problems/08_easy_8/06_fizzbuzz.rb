=begin

fizzbuzz

Write a method that takes two arguments: the first is the starting number,
and the second is the ending number. Print out all numbers between the two
numbers, except if a number is divisible by 3, print "Fizz", if a number is
divisible by 5, print "Buzz", and finally if a number is divisible by 3 and
5, print "FizzBuzz".

Example:

fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz
=end

=begin
Problem
- input: two numbers, starting and ending numbers
- output: ouput the numbers in increments of 1, print "Fizz" if number divisible by 3
          print "Buzz" if divisible by 5, print "FizzBuzz" if divisible by both 3 and 5
          or print the number otherwise

Examples
- See above
- Requirements:
  - All numbers between starting and ending numbers, edge numbers inclusive
  - start_num <= end_num
  - Print "FizzBuzz" instead if number is divisible by both 3 and 5
  - Print "Fizz" in place of number if number is divisible by 3
  - Print "Buzz" in place of number if number is divisible by 5
  - Print number otherwise
  - Have a ", " between each print
  

Data Structure
- input: 2 numbers
- output: numbers, "FizzBuzz", "Fizz" or "Buzz"

Algorithm
1. Iterate through start_num..end_num
  a. If curr_num % 15 == 0, print "FizzBuzz"
     elsif curr_num % 5 == 0, print "Buzz"
     elsif curr_num % 3 == 0, print "Fizz"
     else print curr_num
  b. print ", " if curr_num < end_num
=end

def fizzbuzz(start_num, end_num)
  for curr_num in (start_num..end_num)
    if curr_num % 15 == 0
      print "FizzBuzz"
    elsif curr_num % 5 == 0
      print "Buzz"
    elsif curr_num % 3 == 0
      print "Fizz"
    else
      print curr_num
    end
    print ", " if curr_num < end_num
  end
  puts ""
end
  
fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz


=begin
Solution

def fizzbuzz(starting_number, ending_number)
  result = []
  starting_number.upto(ending_number) do |number|
    result << fizzbuzz_value(number)
  end
  puts result.join(', ')
end

def fizzbuzz_value(number)
  case
  when number % 3 == 0 && number % 5 == 0
    'FizzBuzz'
  when number % 5 == 0
    'Buzz'
  when number % 3 == 0
    'Fizz'
  else
    number
  end
end

Discussion

There may be a couple of things that you haven't encountered in this solution.
First, notice that we use a case statement in the fizzbuzz_value method. This
case statement doesn't have a value next to case for comparison. When using a
case statement in this form, we get the same functionality as if we used an
if/elsif/else conditional.

Another thing of interest is that there isn't anything other than that case
statement in fizzbuzz_value method. This works because a case statement
returns the value from the last line of the matched when branch. For example,
if a number is divisible only by 3, then 'Fizz' is returned from the case
statement. That return value then acts as the return value for the method,
since there are no other lines after this case statement.
=end


=begin
TO REVIEW
- We can actually use a case statement without a value next to it. Equivalent to an if/elsif
  construct
  
  def fizzbuzz_value(number)
    case
    when number % 3 == 0 && number % 5 == 0
      'FizzBuzz'
    when number % 5 == 0
      'Buzz'
    when number % 3 == 0
      'Fizz'
    else
      number
    end
  end
=end