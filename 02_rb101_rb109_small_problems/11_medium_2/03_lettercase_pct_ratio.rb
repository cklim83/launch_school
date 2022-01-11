=begin

Lettercase Percentage Ratio

In the easy exercises, we worked on a problem where we had to count the number
of uppercase and lowercase characters, as well as characters that were neither
of those two. Now we want to go one step further.

Write a method that takes a string, and then returns a hash that contains 3
entries: one represents the percentage of characters in the string that are
lowercase letters, one the percentage of characters that are uppercase letters,
and one the percentage of characters that are neither.

You may assume that the string will always contain at least one character.

Examples

letter_percentages('abCdef 123') == { lowercase: 50.0, uppercase: 10.0, neither: 40.0 }
letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25.0 }
letter_percentages('123') == { lowercase: 0.0, uppercase: 0.0, neither: 100.0 }
=end

=begin
Problem
- input: a string of characters
- output: a hash showing the percentages of lowercase, uppercase and other characters

Examples
- requirements
  - examples of neither include numbers, '+' or white spaces
  - the percentages should be a float of 1 decimal and sum up too 100.0
  - We could have string of only 1 category
  - string will always have at least 1 character

Data Structure
- input: string
- output: hash

Algorithm
1. Set string_length = string.size, lowercase_count = 0, uppercase_count = 0, non_letter_count = 0
2. Iterate over each character of input string
  Increment either one of lowercase_count, uppercase_count or non_letter_count depending on the character
3. Create result hash based on the ratios

How to know if a character is a lowercase, uppercase or non_letter?
  if 'A'..'Z'.include?(character.upcase) 
    if character.upcase == character then increment uppercase_count
    else increment lowercase_count
  else increment non_letter_count
=end

def letter_percentages(string)
  string_length = string.size
  lowercase_count = 0
  uppercase_count = 0
  non_letter_count = 0
  percentage_hash = {}
  
  string.each_char do |char|
    if ('A'..'Z').include?(char.upcase)
      if char.upcase == char
        uppercase_count += 1
      else
        lowercase_count += 1
      end
    else
      non_letter_count += 1
    end
  end
  
  percentage_hash[:lowercase] = ((lowercase_count * 100.0) / string_length).round(1)
  percentage_hash[:uppercase] = ((uppercase_count * 100.0) / string_length).round(1)
  percentage_hash[:neither] = ((non_letter_count * 100.0) / string_length).round(1)
  
  percentage_hash
end

p letter_percentages('abCdef 123') == { lowercase: 50.0, uppercase: 10.0, neither: 40.0 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25.0 }
p letter_percentages('123') == { lowercase: 0.0, uppercase: 0.0, neither: 100.0 }


=begin
TO REVIEW
- Using Range#include?
- Using regex case insensitive compare 
- Using round(1) to round to 1 decimal
=end