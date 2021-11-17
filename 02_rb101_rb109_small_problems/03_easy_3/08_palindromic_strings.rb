=begin

Palindromic Strings (Part 1)

Write a method that returns true if the string passed as an argument is
a palindrome, false otherwise. A palindrome reads the same forward and
backward. For this exercise, case matters as does punctuation and spaces.

Examples:

palindrome?('madam') == true
palindrome?('Madam') == false          # (case matters)
palindrome?("madam i'm adam") == false # (all characters matter)
palindrome?('356653') == true

=end

=begin

Problem
- input: String
- output: Boolean

Other requirements/Clarifying questions
- special characters such as spaces, punctuation matters based on 3rd example
- case matters based on second example
- What should the method return if given an empty string? Assume true

Examples
- See above

Algorithm
- 1) set two indices: front = 0  and back = length of string - 1
- 2) check that front is >= back, break if false 
- 3) compare the characters at these 2 string locations. Return false if the are different
- 4) increment front and decrement back and loop back to step 2
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

p palindrome?('madam') == true
p palindrome?('Madam') == false          # (case matters)
p palindrome?("madam i'm adam") == false # (all characters matter)
p palindrome?('356653') == true


# Further explore without using if, unless, case or other modifiers.
def palindrome2?(sentence)
  front = 0
  back = sentence.size - 1
  
  loop do
    break unless front <= back
    (sentence[front] != sentence[back]) ? (return false) : nil
    front += 1
    back -= 1
  end
  
  true
end

puts ""
p palindrome2?('madam') == true
p palindrome2?('Madam') == false          # (case matters)
p palindrome2?("madam i'm adam") == false # (all characters matter)
p palindrome2?('356653') == true



=begin

Solution

def palindrome?(string)
  string == string.reverse
end

Further Exploration

Write a method that determines whether an array is palindromic; 
that is, the element values appear in the same sequence both forwards
and backwards in the array. Now write a method that determines whether
an array or a string is palindromic; that is, write a method that can
take either an array or a string argument, and determines whether that
argument is a palindrome. You may not use an if, unless, or case statement
or modifier.

Other Solution for further explore

# further exploration 1
def ary_palindrome?(ary)
  output = []
  i = 0
  while i <= ary.size / 2
    ary[i] == ary[(i*-1) - 1] ? output << true : output << false
    i += 1
  end
  output.all?(true)
end

=end