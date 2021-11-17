=begin

Multiples of 3 and 5

Write a method that searches for all multiples of 3 or 5 that lie between 1
and some other number, and then computes the sum of those multiples. For
instance, if the supplied number is 20, the result should be 98 
(3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20).

You may assume that the number passed in is an integer greater than 1.

Examples

multisum(3) == 3
multisum(5) == 8
multisum(10) == 33
multisum(1000) == 234168

=end

=begin

Problem
- input: integer > 1
- output: integer representing the sum of mulitples of 3 or 5 between and 
inclusive of 1 and input integer

Examples
- See above
- Clarification: 
  - Edge case: What should the function return for 2? Assume 0?

Data Structure
- input: Integer
- output: Integer
- intermediary: Probably array storing the multiples

Algorithm
1 - Set counter = 1.
2 - Check if counter is <= input integer. Break if false.
3 - Check if counter is divisible by 3 or 5. If yes, insert in array `required_multiples`
4 - Increment counter
5 - Sum all elements in `required_multiples`

=end


def multisum(cap)
  counter = 1
  required_multiples = []
  loop do
    break if counter > cap
    required_multiples << counter if counter % 3 == 0 || counter % 5 == 0
    counter += 1
  end
  
  required_multiples.sum # return 0 for empty array to handle edge case of 2
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168


=begin

Solution

def multiple?(number, divisor)
  number % divisor == 0
end

def multisum(max_value)
  sum = 0
  1.upto(max_value) do |number|
    if multiple?(number, 3) || multiple?(number, 5)
      sum += number
    end
  end
  sum
end


Discussion

Our solution begins with a multiple? method that returns true if the given
number is an exact multiple of divisor, false if it's not. This method isn't
necessary, but it makes the multisum a bit more readable.

multisum does nothing fancy; it rushes headlong into the problem, and comes
out the other end with the correct result. It adds each value that is a
multiple of 3 or 5 in the range to the sum variable.

Further Exploration

Investigate Enumerable.inject (also known as Enumerable.reduce), How might
this method be useful in solving this problem? (Note that Enumerable methods
are available when working with Arrays.) Try writing such a solution. Which
is clearer? Which is more succinct?

=end