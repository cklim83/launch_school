=begin

Word to Digit

Write a method that takes a sentence string as input, and returns the same
string with any sequence of the words 'zero', 'one', 'two', 'three', 'four',
'five', 'six', 'seven', 'eight', 'nine' converted to a string of digits.

Example:

word_to_digit('Please call me at five five five one two three four. Thanks.') 
== 'Please call me at 5 5 5 1 2 3 4. Thanks.'
=end

=begin
Problem
- input: sentence string
- output: sentence string, with spelled numbers converted

Example
- requirements:
    - Mutate and return original string
    - spelled numbers converted
    - there could be punctuation around the numbers, e.g. `four.`
      If we split string by space to get individual words, the iterate each word and
      try to replace those that matches with the numbers using a hash, we might
      get tripped up by 'four.' which will not match with 'four' hash key
      
Data Structure
- input: string
- output: string
- intermediary: hash to map the word form 'eight' to its equivalent '8'

Algorithm
1. Generate a constant NUMBERS hash with spelled out form as keys and its equivalent as values
2. Iterate each key value pair of NUMBERS, substitute any portion of the input string with its value form
3. Return input string
=end

NUMBERS = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}

def word_to_digit(string)
  NUMBERS.each do |key, value|
    string.gsub!(key, value)
  end
  string
end

p word_to_digit('Please call me at five five five one two three four. Thanks.')\
== 'Please call me at 5 5 5 1 2 3 4. Thanks.'


=begin
TO REVIEW
- String#gsub and its various forms
=end