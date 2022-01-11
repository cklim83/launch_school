=begin

Rotation (Part 2)

Write a method that can rotate the last n digits of a number. For example:

rotate_rightmost_digits(735291, 1) == 735291
rotate_rightmost_digits(735291, 2) == 735219
rotate_rightmost_digits(735291, 3) == 735912
rotate_rightmost_digits(735291, 4) == 732915
rotate_rightmost_digits(735291, 5) == 752913
rotate_rightmost_digits(735291, 6) == 352917

Note that rotating just 1 digit results in the original number being returned.

You may use the rotate_array method from the previous exercise if you want. (Recommended!)

You may assume that n is always a positive integer.
=end

=begin
Problem
- input: 2 number arguments, the first is the number to be rotated, the second 
         is n, the number of digits to be rotated
- output: rotated number

Examples
- requirements
  - n is also positive. maximum value of n is the number of digits in the 1st argument
  - digits to be rotated always start from the end
  - just rotating one digit will return the same number
  - number is an integer

Data Structure:
- inputs: 2 numbers
- output: 1 rotated number
- intermediary: array or string to perform the rotation function

Algorithm
1. num_str = num.to_s
2. set str_length = num_str.size
3. back_str = str[-n..-1]
4. front_str = str[0..str_length-n-1] => this will fail when n = str_length which will return the [0..-1], the full string
5. back_str = back_str[1..-1] + back_str[0]
6. rotated_str = front_str + back_str
7. return rotated_str.to_i
=end

def rotate_rightmost_digits(num, n)
  num_str = num.to_s
  str_length = num_str.size
  back_str = num_str[-n..-1]
  front_str = num_str[0...str_length-n]  # if n = str_length [0..str_length-n-1] => [0..-1], the full string changing to [0...0] will solve this problem
  rotated_back_str = back_str[1..-1] + back_str[0]
  rotated_str = front_str + rotated_back_str
  rotated_str.to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917


=begin
Solution

def rotate_rightmost_digits(number, n)
  all_digits = number.to_s.chars
  all_digits[-n..-1] = rotate_array(all_digits[-n..-1])
  all_digits.join.to_i
end

Discussion

Don't be alarmed if your solution is considerably longer than our solution,
so long as it produces the correct results.

Since we will be working with rotate_array, we need an array. To do this,
we simply convert the number to a string, and then split it out into its
individual digits. That's the easy part.

Now the tricky part. First, there's this:

all_digits[-n..-1]

This construct returns the last n elements of the all_digits array. It's
a handy shorthand to know about, as you're likely to be using it more
than you might think.

We pass all_digits[-n..-1] to our rotate_array method from the previous
exercise, and that method returns a new array with the digits rotated as
needed.

We then assign the return value of rotate_array to all_digits[-n..-1].
When an expression like this appears on the left side of an assignment,
it means, "replace the last n elements with the values to the right of
the equal sign". And that's exactly what happens here: we replace the
last n digits with the rotated digits.

Finally, we convert the all_digits array back to an integer.
=end


=begin
TO REVIEW (Important property of using negative indices)
- slice[0..size-n-1] causes the last test case 
    rotate_rightmost_digits(735291, 6) == 352917
  
  to fail since size = n and slice simplifies to slice[0..-1] which cause front_str
  in the algorithm to return the full string rather than the intended "". Changing it 
  to slice[0...size-n] solves this since "abc"[0...0] returns ""
  
  Original Error in Algorithm
  4. front_str = str[0..str_length-n-1] # to be excluded from rotation
  5. back_str = back_str[1..-1] + back_str[0] # rotated back string 
  6. rotated_str = front_str + back_str
  
  Revision to fix the edge case bug
  4. front_str = str[0...str_length-n] # to be excluded from rotation
  5. back_str = back_str[1..-1] + back_str[0] # rotated back string
  6. rotated_str = front_str + back_str
=end