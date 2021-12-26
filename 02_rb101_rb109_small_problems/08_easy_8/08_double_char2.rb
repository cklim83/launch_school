=begin

Double Char (Part 2)

Write a method that takes a string, and returns a new string in which
every consonant character is doubled. Vowels (a,e,i,o,u), digits,
punctuation, and whitespace should not be doubled.

Examples:

double_consonants('String') == "SSttrrinngg"
double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
double_consonants("July 4th") == "JJullyy 4tthh"
double_consonants('') == ""
=end

=begin
Problem
- input: a string
- output: new string with only consonants doubled

Examples
- See above
- requirements
  - Consonants (in any casing) doubled, casing preserved
  - Characters can be non-alphabetical
  - Edge case: return empty string if input is empty string

Data Structure:
- input: string
- output: new sting

Algorithm
1. set new_str = ""
2. Set consonants = 'a..z'.to_a.difference('aeiou'.chars) + 'A..Z'.to_a.difference("AEIOU".chars)
3. Iterate through each character in string
  a. append char to new_str
  b. if consonants include char, append character in new_str again
4. return new_str
=end

def double_consonants(string)
  consonants = ('a'..'z').to_a.difference('aeiou'.chars) + ("A"..'Z').to_a.difference('AEIOU'.chars)
  new_str = ""
  
  string.each_char do |char|
    new_str << char
    new_str << char if consonants.include?(char)
  end
  
  new_str
end


p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""


=begin
Solution

CONSONANTS = %w(b c d f g h j k l m n p q r s t v w x y z)

def double_consonants(string)
  result = ''
  string.each_char do |char|
    result << char
    result << char if CONSONANTS.include?(char.downcase)
  end
  result
end

Discussion

This exercise is nearly identical to the previous exercise, so it should
come as no surprise that the solution is also similar. The main difference
here is that we need to check each character to see if it is a consonant.
There are lots of ways to do this: we have chosen to use an array of the
lowercase consonants, and just check each character to see if it is in that
array. Of course, we do need to account for uppercase consonants as well,
so we convert each character to lowercase for the test.
=end


=begin
TO REVIEW

- Mistakes in original solutioning
  - Using delete wrongly, thinking it can delete multiple characters
      ('a'..'z').to_a.delete('aeiou') => returns nil rather than lower case consonants 
      because
    
        ['a', 'b', 'e'].delete('ae') => returns nil
        ['a', 'b', 'e'].delete('a') => returns 'a'
        
  
  - by calling upcase on an array of characters to get the upcase consonants.
      consonants = ('a'..'z').to_a.delete('aeiou')
      consonants += consonants.upcase
      
- Correct solutions 
  
  - use difference(other_array) to subtract elements in other_array from array
    ('a'..'z').to_a.difference('aeiou'.chars) + ('A'..'Z').to_a.difference('AEIOU'.chars)
    
    OR
  
  - use strings
  consonants_str = ("a".."z").to_a.join.delete("aeiou") =>"bcdfghjklmnpqrstvwxyz" 
  consonants_str += consonants_str.upcase => "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ" 
  
  String#include? 
  "abc".include?("a") => true
  "abc".include?("ab") => true
  "abc".include?("ac") => false
  
  "abc".include?("abc") => true
  "abc".include?("abcd") => false
=end

