=begin

Double Char (Part 1)

Write a method that takes a string, and returns a new string in which
every character is doubled.

Examples:

repeater('Hello') == "HHeelllloo"
repeater("Good job!") == "GGoooodd  jjoobb!!"
repeater('') == ''
=end

=begin
Problem
- input: string
- output: a new string where every char in the given string appears twice

Examples
- see above
- requirements:
  - Every character is doubled, maintaining the same casing
  - Spaces and punctuation also doubled. Doubling apply to all characters
  - Edge case: empty string returns an empty string
  
Data Structure
- input: string
- output: new string with characters doubled
- intermediary: not needed

Algorithm
1. Set doubled_str = ""
2. Iterate through each character in given string
  a.  Append each character twice in doubled_str
3. Return doubled_str
=end

def repeater(string)
  doubled_str = ""
  string.each_char do |char|
    doubled_str << char << char
    # doubled_str.concat(char*2)
    # doubled_str.concat(char, char)
  end
  
  doubled_str
end

p repeater('Hello') == "HHeelllloo"
p repeater("Good job!") == "GGoooodd  jjoobb!!"
p repeater('') == ''


=begin
Solution

def repeater(string)
  result = ''
  string.each_char do |char|
    result << char << char
  end
  result
end

Discussion

This solution is straightforward. We initialize a result string,
then iterate through the original string while appending each character
to the result 2 times. Finally, we return the result string.
=end


=begin
TO REVIEW
- String do not have #each but have #each_char. Since String do not have each method,
  we also cannot iterate using `for`

- We can concatenate with one of the following forms
  
  doubled_str << char << char
  doubled_str.concat(char*2)
  doubled_str.concat(char, char)
=end