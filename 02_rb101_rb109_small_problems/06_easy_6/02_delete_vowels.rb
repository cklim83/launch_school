=begin

Delete vowels

Write a method that takes an array of strings, and returns an array of the
same string values, except with the vowels (a, e, i, o, u) removed.

Example:

remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']
=end

=begin
Problem
- input: array of strings
- output: array of strings, each string with vowel characters deleted

Examples
- See above
- Implicit requirements: 
  - VOWELS to be removed can be in lower or upper case
  - cases of original strings to be maintained
  - modified string can be an empty string
- Can input array be empty? Return empty array?

Data Structure
- Input: array
- Output: array
- Intermediary: Likely an array

Algorithm
0. Return array is if it empty (edge case)
1. Iterate through each input string
2. For each string, make a dup copy of string
3. Iterate copy character by character, delete character of original string
   if it is equal 'aeiouAEIOU'
4. Return modified strings in new array.
5. Return new array

=end
VOWELS = 'aeiouAEIOU'

def remove_vowels(strings)
  return strings if strings.size == 0 # edge case empty array
  
  strings.map do |string|
    VOWELS.each_char do |vowel|
      string.delete!(vowel) 
    end
    
    string
  end
end


p remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
p remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
p remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']

=begin
Solution

def remove_vowels(strings)
  strings.map { |string| string.delete('aeiouAEIOU') }
end

Discussion

Our solution uses String#delete to remove all of the vowels from each
string. We use map to iterate through the array since it is ideal for
transformations like this.

Further Exploration

Ruby has all sorts of String methods that could accomplish this task.
How did you end up solving this exercise?
=end

=begin
**TO REVIEW** 
- String#delete is not destructive? We need String#delete!
- String#delete("aeiouAEIOU") will remove all occurrences of all vowels
  in 1 go. We do not need to iterate and delete vowel by vowel.
=end