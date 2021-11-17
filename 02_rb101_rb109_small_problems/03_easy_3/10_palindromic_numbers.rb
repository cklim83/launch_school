=begin

Palindromic Numbers

Write a method that returns true if its integer argument is palindromic,
false otherwise. A palindromic number reads the same forwards and backwards.

Examples:

palindromic_number?(34543) == true
palindromic_number?(123210) == false
palindromic_number?(22) == true
palindromic_number?(5) == true

=end

=begin

Problem
- input: Integer
- output: Boolean


Examples
- See above

Algorithm
- 1) Convert the number to string
- 2) set two indices: front = 0  and back = length of string - 1
- 2) check that front is >= back, break if false 
- 3) compare the characters at these 2 string locations. Return false if the are different
- 4) increment front and decrement back and loop back to step 3
- 5) Return true

=end

def palindrome?(sentence)
  front = 0
  back = sentence.size - 1
  
  loop do
    break unless front <= back
    return false if sentence[front] != sentence[back]
    front += 1
    back -= 1
  end
  
  true
end

def palindromic_number?(number)
  number_str = number.to_s
  p number_str
  palindrome?(number_str)
end

p palindromic_number?(34543) == true
p palindromic_number?(123210) == false
p palindromic_number?(22) == true
p palindromic_number?(5) == true

# Further Exploration
puts ""
puts "Further Exploration"
p palindromic_number?(0045400) == true


=begin

Solution

def palindromic_number?(number)
  palindrome?(number.to_s)
end

Discussion

The hardest part of this program is recognizing that the easiest way to
tell if a number is palindromic is to convert it to a string first, then
check whether that string is palindromic. To determine if the string is
palindromic, we use the palindrome? method we wrote earlier.

Further Exploration

Suppose your number begins with one or more 0s. Will your method still work?
Why or why not? Is there any way to address this?

No. 0045400.to_s returns '19200' which seemed to equate 0045400.ord.to_s which
distort the original palindromic characteristics. None that i know of.

=end