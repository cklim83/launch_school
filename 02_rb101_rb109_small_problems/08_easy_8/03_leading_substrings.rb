=begin

Leading Substrings

Write a method that returns a list of all substrings of a string that start
at the beginning of the original string. The return value should be arranged
in order from shortest to longest substring.

Examples:

leading_substrings('abc') == ['a', 'ab', 'abc']
leading_substrings('a') == ['a']
leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']
=end

=begin
Problem
- input: a string
- output: an array containing all the leading substrings

Examples
- see above
- requirements
  - number of substrings equals the length of input string
  - assume any character can be used in the string and substrings, including non-letters
  - Edge case: input string is an empty string, return an empty array
  
Data Structure
- input: a string
- output: an array of substrings

Algorithm
1. Set substrings = [], substring = ""
2. Iterate through each character in string
  1. substring += character
  2. substrings << substring
3. Return substrings
=end

def leading_substrings(string)
  substrings = []
  substring = ""
  
  string.each_char do |char|
    substring += char
    substrings << substring
  end
  
  substrings
end
  

p leading_substrings('abc') == ['a', 'ab', 'abc']
p leading_substrings('a') == ['a']
p leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']


=begin
Solution

def leading_substrings(string)
  result = []
  0.upto(string.size - 1) do |index|
    result << string[0..index]
  end
  result
end

Discussion

This problem is straightforward; all we need to do is to iterate through the
characters of a string, returning each substring that starts at the beginning
of the string, and ends with the character we are currently iterating.

The hardest part of this problem is determining the correct looping structure
to use; we decided to use upto, but any looping structure that works would be
fine.

The expression string[0..index] may need a bit of explanation; it simply
returns a substring of string. The substring starts at position 0, and ends
at position index.
=end

=begin
** TO REVIEW **
- Using substring << char will meant that all array elements are pointing to the same object, 
  we need to use += to generate a new substring each time
  
  def leading_substrings(string)
    substrings = []
    substring = ""
  
    string.each_char do |char|
      substring += char
      substrings << substring
    end
  
    substrings
  end
  
  p leading_substrings('abc') => ['abc', 'abc', 'abc']
  
- use #slice(range)
- meaning of leading substrings
=end