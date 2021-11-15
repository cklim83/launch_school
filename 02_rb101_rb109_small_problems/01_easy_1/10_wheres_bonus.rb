=begin

What's my Bonus?

Write a method that takes two arguments, a positive integer and a boolean,
and calculates the bonus for a given salary. If the boolean is true, the
bonus should be half of the salary. If the boolean is false, the bonus
should be 0.

Examples:

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000

The tests above should print true.

=end

=begin

Problem
- Inputs: A positive integer and a boolean
- Output: A number
- Clarifications: Should the output be a integer or can be a float? 
                  We will ASSUME we do integer division and return an integer 

Examples:
- See above

Data Structure:
- Input: Integer and boolean
- Output: Integer

Algorithm
- Return 0 if boolean is false, else return input number divided by 2

=end

def calculate_bonus(salary, got_bonus)
  got_bonus ? (salary / 2) : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000


=begin

Solution

def calculate_bonus(salary, bonus)
  bonus ? (salary / 2) : 0
end

Discussion

The solution to this exercise takes advantage of the ternary operator.
We're able to use bonus as the condition because it's a boolean, which
means its value will only be true or false. If it's true, then we divide
salary by 2 and return the quotient. If it's false, then we return 0.

=end
