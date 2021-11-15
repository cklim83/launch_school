=begin

Reverse It (Part 1)

Write a method that takes one argument, a string, and returns a new string
with the words in reverse order.

Examples:

puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
puts reverse_sentence('') == ''
puts reverse_sentence('    ') == '' # Any number of spaces results in ''

The tests above should print true.

=end

=begin
Problem
- Input: String of 0 or more words
- Output: Position of words in sentence appears in reverse order
- Requirements:
  - Unit of reverse at sentence level
  - Capitalization of words maintained even after reversal
  - Delimiter is ' '
  - Returns "" if no words
 
Examples
- See test cases

Data structure
- Input: String
- Output: String
- Intermediary: Array of words, reversing of order
 
Algorithm
- Split string into array of words using ' ' as delimiter
- Create empty result array
- Take the last element and insert into tail of result array
- repeat previous step until original word array is empty
- join the elements of result array with ' ' as delimiter to form a string
- Edge cases: If original string has no words, return ""
 
=end
 
def reverse_sentence(string)
  words = string.split(" ")
  result = []
  loop do
    break if words.size == 0 
    word = words.pop
    result << word
  end
  
  result.join(" ") # return "" if result is empty array
end

# test cases
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
puts reverse_sentence('') == ''
puts reverse_sentence('    ') == '' # Any number of spaces results in ''


=begin

Solution

def reverse_sentence(string)
  string.split.reverse.join(' ')
end

Discussion

To reverse the order of substrings within a string, we first need to separate
those substrings. In our solution, we use #split with no arguments to separate
each word and place it in an array. To reverse the order of the words, we then
invoke #reverse on the array. Now, string looks like this:

'Hello World'.split.reverse # => ["World", "Hello"]

That's precisely what we want except we need it to be a string, not an array.
To accomplish this, we invoke #join which joins every element in an array
using the given argument as the delimiter.

Note that we don't need to do anything special to handle the last two tests.
Since split splits on whitespace when invoked without an argument, both ''
and ' ' cause split to return an empty array.


TO REVIEW: String#split will split with whitespace as default argument.
We need not provide an argument split(' ').

https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-split

Extract
split(pattern=nil, [limit]) → an_array
split(pattern=nil, [limit]) {|sub| block } → str


"If pattern is nil, the value of $; is used. If $; is nil (which is the
default), str is split on whitespace as if ' ' were specified."


" now's  the time ".split       #=> ["now's", "the", "time"]
" now's  the time ".split(' ')  #=> ["now's", "the", "time"]

=end