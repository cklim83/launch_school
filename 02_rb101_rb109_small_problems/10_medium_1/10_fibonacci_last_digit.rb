=begin

Fibonacci Numbers (Last Digit)

In the previous exercise, we developed a procedural method for computing
the value of the nth Fibonacci numbers. This method was really fast,
computing the 20899 digit 100,001st Fibonacci sequence almost instantly.

In this exercise, you are going to compute a method that returns the last
digit of the nth Fibonacci number.

Examples:

fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
fibonacci_last(123456789) # -> 4
=end

=begin
Problem
- input: a integer for the nth value of the fibonacci sequence
- output: the last digit of the nth value

Examples
- requirements
  - return the last digit of the nth value of the fibonacci sequence
  - n is positive integer and can be too large to use recursion
  
Data Structure
- input: integer
- output: integer

Algorithm
1. find the nth fibonacci value procedurely is too slow for the last 2 test examples. 
2. return 1 if n is 1 or 2
3. set prev_last_digits = [1, 1] to store last digits of fibonacci sequence since only the last
   digits of the previous 2 numbers in the sequence affect the last digit of the current value
4. for 3 to n, compute the current last digit by summing prev_last_digits % 10 and push it to
   prev_last_digits. Remove the first element of the array
5. return the last value of array
=end

def fibonacci_last(n)
  return 1 if n.between?(1, 2)
  prev_last_digits = [1, 1]
  
  3.upto(n) do |_|
    prev_last_digits << prev_last_digits.sum % 10
    prev_last_digits.shift
  end
  
  prev_last_digits.last
end


p fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
p fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
p fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
p fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
p fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
p fibonacci_last(123456789) # -> 4