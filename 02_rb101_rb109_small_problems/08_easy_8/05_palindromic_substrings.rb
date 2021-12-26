=begin

Palindromic Substrings

Write a method that returns a list of all substrings of a string that are
palindromic. That is, each substring must consist of the same sequence of
characters forwards as it does backwards. The return value should be
arranged in the same sequence as the substrings appear in the string.
Duplicate palindromes should be included multiple times.

You may (and should) use the substrings method you wrote in the previous
exercise.

For the purposes of this exercise, you should consider all characters and
pay attention to case; that is, "AbcbA" is a palindrome, but neither
"Abcba" nor "Abc-bA" are. In addition, assume that single characters are
not palindromes.

Examples:

palindromes('abcd') == []
palindromes('madam') == ['madam', 'ada']
palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
  ]

=end

=begin
Problem
- input: string
- output: array of substrings that are palindromic

Examples
- see above
- requirements
  - return empty if no palindromic substrings
  - return value should be in same order as substrings in strings
    e.g. 'madam' => ['m', 'ma', 'mad', 'mada', 'madam'
                     'a', 'ad', 'ada', 'adam',
                     'd', 'da', 'dam',
                     'a', 'am',
                     'm'
    ], of which only 'madam' and 'ada' are non-single word palimdromes and should be in that order
  - palindromes are case sensitive
  - non-letters are not ommitted
  - single characters are not palindrome
  - palindromes can be non-unique e.g. 'tt' and 'tt' in last example

Data Structure
- input: string
- output: array of palindromic non-unique contiguous substrings
- intermediary: array of all non-unique, contiguous substrings

Algorithm
1. Set substrings = substrings(string) from 04_all_substrings
2. Iterate through each substring, select if palindromic? return true
3. Return selection.

palindromic? Algorithm
1. set str_length = string.size, middle = str_length / 2, front_index = 0, back_index = -1
2. return false is size < 2
3. while front_index < middle
  a. if string[front_index] == string[back_index], increment front_index, decrement back_index
  b. else return false
4. Return true
=end

def leading_substrings(curr_string)
  length = curr_string.size
  end_index = 0
  substrings = []
  
  while end_index < length
    substrings << curr_string.slice(0..end_index)
    end_index += 1
  end
  
  substrings
end

def substrings(string)
  curr_index = 0
  str_length = string.size
  all_substrings = []
  
  while curr_index < str_length
    substring = string.slice(curr_index...str_length)
    all_substrings << leading_substrings(substring)
    curr_index += 1
  end
  
  all_substrings.flatten
end

def palindromic?(string)
  str_length = string.size
  return false if str_length < 2
  
  midpoint_limit = str_length / 2
  front_index = 0
  back_index = -1
  
  while front_index < midpoint_limit
    if string[front_index] == string[back_index]
      front_index += 1
      back_index -= 1
    else
      return false
    end
  end
  
  true
end


def palindromes(string)
  substrings = substrings(string)
  substrings.select do |substring|
    palindromic?(substring)
  end
end
  
  
p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
  ]
  

=begin
Solution

def palindromes(string)
  all_substrings = substrings(string)
  results = []
  all_substrings.each do |substring|
    results << substring if palindrome?(substring)
  end
  results
end

def palindrome?(string)
  string == string.reverse && string.size > 1
end

Discussion

Again, this problem is much easier if you use the method from the previous
exercise. Building this method from scratch is sure to leave you with an
aching head.

We'll use a helper method here, palindrome?, to test whether any given string
is a palindrome. Note that we need to verify the size of the string as well
as its reversibility.

The main method just calls substrings from the previous exercise, and then
constructs a list of all of the return values that are palindromic.

Further Exploration

Can you modify this method (and/or its predecessors) to ignore non-alphanumeric
characters and case? Alphanumeric characters are alphabetic characters(upper
and lowercase) and digits.
=end

=begin
TO REVIEW
- use String == String.reverse to perform palindrome checks if we do not need to build from scratch

- if we are checking palindrome from scratch, note the loop limit is front_index < string_length / 2 
  (since if the length is odd, the middle character need not be checked if we are considering all 
  types of characters).
=end