=begin

Fibonacci Number Location By Length

The Fibonacci series is a series of numbers (1, 1, 2, 3, 5, 8, 13, 21, ...)
such that the first 2 numbers are 1 by definition, and each subsequent number
is the sum of the two previous numbers. This series appears throughout the
natural world.

Computationally, the Fibonacci series is a very simple series, but the
results grow at an incredibly rapid rate. For example, the 100th Fibonacci
number is 354,224,848,179,261,915,075 -- that's enormous, especially
considering that it takes 6 iterations before it generates the first 2 digit
number.

Write a method that calculates and returns the index of the first Fibonacci
number that has the number of digits specified as an argument. (The first
Fibonacci number has index 1.)

Examples:

find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
find_fibonacci_index_by_length(10) == 45
find_fibonacci_index_by_length(100) == 476
find_fibonacci_index_by_length(1000) == 4782
find_fibonacci_index_by_length(10000) == 47847

You may assume that the argument is always greater than or equal to 2.
=end

=begin
Problem
- input: integer represent number of digits of number
- output: integer representing smallest index in fibo number sequence
          with required number of digits

Examples
- See above
- Explicit requirements
  - Number of digits at least 2
- Implicit requirements:
  - index starts from 1
  - Able to handle to at least 10,000 digits
  
Data Structure
- input: integer
- output: integer
- intermediary: maybe an array

Algorithm
1. Generate the next fibo number and its index
2. Check the number of digits of fibo number
3. If number of digits of fibo numbers equal argument, return index. Else go to 1.

get_num_digits
1. number of digits = 1
2. quotient = num / 10
3. if quotient == 0, return num_digits, else increment_num_digits, num = quotient, then go to 2.

=end
def next_fibo_number(last_two_nums, index)
  next_num = last_two_nums.sum
  updated_fibo_nums = [last_two_nums.last, next_num]
  index += 1
  [updated_fibo_nums, index]
end

def num_digits(num)
  curr_digit_count = 1
  
  loop do
    quotient = num / 10
    break if quotient == 0
    curr_digit_count += 1
    num = quotient
  end
  
  curr_digit_count
end

def find_fibonacci_index_by_length(length)
  fibo_array = [1, 1]
  current_index = 2
  loop do
    fibo_array, current_index = next_fibo_number(fibo_array, current_index)
    break if num_digits(fibo_array.last) == length
  end
  
  current_index
end

p num_digits(1) == 1
p num_digits(29) == 2
p num_digits(456) == 3
p num_digits(1863) == 4
p next_fibo_number([1, 1], 2) == [[1, 2], 3]
p next_fibo_number([1, 2], 3) == [[2, 3], 4]

p find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
p find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
p find_fibonacci_index_by_length(10) == 45
p find_fibonacci_index_by_length(100) == 476
p find_fibonacci_index_by_length(1000) == 4782
p find_fibonacci_index_by_length(10000) == 47847


=begin
Solution

def find_fibonacci_index_by_length(number_digits)
  first = 1
  second = 1
  index = 2

  loop do
    index += 1
    fibonacci = first + second
    break if fibonacci.to_s.size >= number_digits

    first = second
    second = fibonacci
  end

  index
end

Discussion

We'll take the brute force approach for this solution; it's the easiest form
to both understand and write.

We start by setting the first 2 numbers, first and second, to 1 in accordance
with the series definition. We start our index at 2 since we now have the 2nd
Fibonacci number in second.

We then begin iterating through the numbers, exiting the loop when we finally
encounter a Fibonacci number of the correct size (note that we check whether
the result is >= the required number of digits; the > part of this comparison
will probably never be true, but it's safer to ensure that we don't end up in
an infinite loop, just in case there are no numbers with the exact number of
digits we want).

During each iteration, we first increment our index, then compute the newest
number in the sequence by adding the last 2 numbers together. After checking
for the desired result, we then replace first and second with the pair of
numbers that will be used in the next calculation.

Finally, we return our index; this is the index of the first Fibonacci number
with number_digits digits.
Further Exploration

Fibonacci numbers are sometimes used in demonstrations of how to write
recursive methods. Had we tried to use a recursive method, it probably would
have resulted in the program running out of stack space. Ruby isn't well
equipped to deal with the level of recursion required for a recursive solution.

We'll explore Fibonacci numbers again, along with the usual recursive
solutions, later in the Medium exercises.

=end

=begin
TO REVIEW:
- We could have done the fibo within the function using loop
- We use convert number to string and get the size to know the digit count
=end