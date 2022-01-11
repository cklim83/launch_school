=begin

Rotation (Part 3)

If you take a number like 735291, and rotate it to the left, you get 352917.
If you now keep the first digit fixed in place, and rotate the remaining
digits, you get 329175. Keep the first 2 digits fixed in place and rotate
again to 321759. Keep the first 3 digits fixed in place and rotate again to
get 321597. Finally, keep the first 4 digits fixed in place and rotate the
final 2 digits to get 321579. The resulting number is called the maximum
rotation of the original number.

Write a method that takes an integer as argument, and returns the maximum
rotation of that argument. You can (and probably should) use the
rotate_rightmost_digits method from the previous exercise.

Note that you do not have to handle multiple 0s.

Example:

max_rotation(735291) == 321579
max_rotation(3) == 3
max_rotation(35) == 53
max_rotation(105) == 15 # the leading zero gets dropped
max_rotation(8_703_529_146) == 7_321_609_845
=end

=begin
Problem
- input: an integer
- ouput: integer rotated n-1 times, where n is the number of digits of input
  735291 -> 352917 -> 329175 -> 321759 -> 321597 -> 321579
  
Examples
- requirements
  - input is 0 or positive
  - any leading zeros arising from rotation is dropped so that output number can
    have less digits than input

Data Structure
- input: non-negative integer
- output: max rotated integer
- intermediary: array or string

Algorithm
1. convert num to string assign to num_str
2. set n = num_str.size
3. while n > 1
    rotated_num = rotate_rightmost_digits(num_str, n)
    num_str = rotated_num.to_s
    n -= 1
4. convert num_str to integer for return
=end


def rotate_rightmost_digits(num, n)
  num_str = num.to_s
  str_length = num_str.size
  back_str = num_str[-n..-1]
  front_str = num_str[0...str_length-n]  
  rotated_back_str = back_str[1..-1] + back_str[0]
  rotated_str = front_str + rotated_back_str
  rotated_str.to_i
end

def max_rotation(num)
  n = num.to_s.size
  while n > 1
    num = rotate_rightmost_digits(num, n)
    n -= 1
  end
  num
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845


=begin
Solution

def max_rotation(number)
  number_digits = number.to_s.size
  number_digits.downto(2) do |n|
    number = rotate_rightmost_digits(number, n)
  end
  number
end

Discussion

Our max_rotation method begins by first determining how many digits we have,
then starts up a loop. The loop repeatedly rotates the number, starting with
the rightmost n digits, then the rightmost n - 1 digits, and so on, until we
get down to the last 2 digits. (We could also include 1, but it is not needed
since it does not modify the number when we rotate just the last digit.)

Further Exploration

Assume you do not have the rotate_rightmost_digits or rotate_array methods.
How would you approach this problem? Would your solution look different?
Does this 3 part approach make the problem easier to understand or harder?
=end

There is an edge case in our problem when the number passed in as the argument has multiple consecutive zeros. Can you create a solution that preserves zeros?
=end