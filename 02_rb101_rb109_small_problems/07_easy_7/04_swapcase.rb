=begin

Swap Case

Write a method that takes a string as an argument and returns a new string
in which every uppercase letter is replaced by its lowercase version, and
every lowercase letter by its uppercase version. All other characters should
be unchanged.

You may not use String#swapcase; write your own version of this method.

Example:

swapcase('CamelCase') == 'cAMELcASE'
swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'
=end

=begin
Problem
- input: string
- output: new string where cases of words are inverted

Examples
- see above
- requirement:
  - string can have 0 or more words
  - we can hsve non alphabetical characters e.g. '-' for which no case inversion is needed

Data Structure
- input: string
- output: new string
- intermediary: 

Algorithm
1. set case_gap to the position difference between 'a' and 'A'
2. Iterate through each char in input string, 
  1. map uppercase letters to lowercase or
  2. lowercase to uppercase or
  3. otherwise unchanged
3. Join the transformed characters with "" as delimiter for swapped_str
=end


def swapcase(string)
  case_gap = 'a'.ord - 'A'.ord
  
  swapped_str = string.chars.map do |char|
    case char
    when 'A'..'Z' then (char.ord + case_gap).chr
    when 'a'..'z' then (char.ord - case_gap).chr
    else char
    end
  end
  swapped_str.join("")
end


p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'


=begin
Solution

def swapcase(string)
  characters = string.chars.map do |char|
    if char =~ /[a-z]/
      char.upcase
    elsif char =~ /[A-Z]/
      char.downcase
    else
      char
    end
  end
  characters.join
end

Discussion

In our solution, we iterate through each character in the string passed into
swapcase. If the character is lowercase (/[a-z]/), we make it uppercase; if
it is uppercase (/[A-Z]/), we make it lowercase. For all other characters,
we do nothing.

Each character is then mapped to a new array and assigned to characters.
Finally, we join characters together into a new String and return that value.
=end

=begin
TO REVIEW
- regex syntax
  - char =~ /[a-z]/ 
=end