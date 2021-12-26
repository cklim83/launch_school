=begin

Reverse the Digits In a Number

Write a method that takes a positive integer as an argument and returns
that number with its digits reversed. Examples:

reversed_number(12345) == 54321
reversed_number(12213) == 31221
reversed_number(456) == 654
reversed_number(12000) == 21 # No leading zeros in return value!
reversed_number(12003) == 30021
reversed_number(1) == 1

Don't worry about arguments with leading zeros - Ruby sees those as octal
numbers, which will cause confusing results. For similar reasons, the
return value for our fourth example doesn't have any leading zeros.
=end

=begin
Problem
- input: positive integer
- output: number with digits reversed

Examples
- see above
- requirements:
  - no leading zeros needed, input and output need not have same length
  - edge cases: single digit, dun really need to reverse them

Data Structure
- input: integer
- output: integer
- intermediary: string

Algorithm
1. Convert the number to string equivalent
2. Reverse the string, then convert back to integer
=end

def reversed_number(num)
  num.to_s.reverse.to_i
end


p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21 # No leading zeros in return value!
p reversed_number(12003) == 30021
p reversed_number(1) == 1


=begin
Solution

def reversed_number(number)
  string = number.to_s
  reversed_string = string.reverse
  reversed_string.to_i
end

Discussion

This exercise has a lot of different solutions. We'll use an approach that
talks more about logical steps than procedural descriptions. Instead of
saying "Iterate over the number's digits and put them together in reverse
order," which will probably lead to a loop-based method, we'll talk in more
general terms that model what we know we can do with strings and numbers:
"Convert the number to a string (Integer#to_s). Reverse the string
(String#reverse). Convert the result to a number (String#to_i)."

This task list lets us write out the solution in a natural way. In our
solution, we use Integer#to_s to convert the number to a String, then
String#reverse to reverse the String, and then use String#to_i to get
the final result.

It's fine if you used a loop to solve this yourself; we haven't seen
many solutions like this so far. The key to this approach is to break
the problem down into logical steps that mirror the operations you can
perform on the types used in your method. With time, this will seem
more natural than writing a loop.
=end