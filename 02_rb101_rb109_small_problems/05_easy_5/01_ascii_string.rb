=begin

ASCII String Value

Write a method that determines and returns the ASCII string value of a string
that is passed in as an argument. The ASCII string value is the sum of the
ASCII values of every character in the string. (You may use String#ord to
determine the ASCII value of a character.)

ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0

=end

=begin
Problem
- input: strings, can be empty
- output: integer representing sum of ascii values making up string

Examples
- See above
- String can contain any character in the ascii table. They can also be empty.


Data Structure
- input: A string
- output: Integers
- Intermediary: array containing characters of input string

Algorithm
1 return 0 if string is empty. This will handle the edge case in the last test example
2 Otherwise, set total to 0
3 Iterate over each character, invoke the ord method on the character and add the value to total
4 return total

=end

def ascii_value(sentence)
  return 0 if sentence.size == 0 # redundant since expression below will return 0 for empty string
  
  sentence.chars.reduce(0) { |total, char| total + char.ord }
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0


=begin

Solution

def ascii_value(string)
  sum = 0
  string.each_char { |char| sum += char.ord }
  sum
end

Discussion

There isn't much to say here. We initialize the sum to 0 (which takes care
of the empty string case in addition to giving us a starting value), then
add String#ord for every character to that sum. Finally, we return the sum.

Further Exploration

There is an Integer method such that:

char.ord.mystery == char

where mystery is our mystery method. Can you determine what method name
should be used in place of mystery? What happens if you try this with a
longer string instead of a single character?

=end

puts "\nFurther Exploration"
p 'a'.ord.chr == 'a' # method is Integer#chr
p 'ab'.ord.chr == 'a'
p 'ba'.ord.chr == 'b'
# ord only return the value of first character, so this doesnt work for multiple characters


=begin

TO REVIEW
- String#each_char to iterate character by character in string

https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-each_char

each_char {|cstr| block } → str
each_char → an_enumerator

Passes each character in str to the given block, or returns an enumerator
if no block is given.

"hello".each_char {|c| print c, ' ' }

produces:

h e l l o

=end