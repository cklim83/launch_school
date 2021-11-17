=begin

Counting the Number of Characters

Write a program that will ask a user for an input of a word or multiple
words and give back the number of characters. Spaces should not be
counted as a character.

input:

Please write word or multiple words: walk

output:

There are 4 characters in "walk".

input:

Please write word or multiple words: walk, don't run

output:

There are 13 characters in "walk, don't run".

=end

=begin
Problem
- Input: A string containing one or more words
- Output: A string indicating number of characters in input string, whitespace not included
- Implicit Requirements from examples
  - Non space characters are to be counted, including punctuations/special characters/symbols
  - Assume repeated characters are also counted
  
Examples
- See above

Data Structure:
- Input: A String containing 1 or more words
- Output: A String showing number of non space characters
- Intermediary: An array storing non-space characters

Algorithm
- Remove all space in input string and assign to processed_str
- Split processed_str into characters and store in array
- Count the number of elements in array
- Formulate output string

=end

print "Please write word or multiple words: "
sentence = gets.chomp
processed_string = sentence.gsub(" ", "")
char_count = processed_string.size

puts "There are #{char_count} chars in \"#{sentence}\"."


=begin

Solution

print 'Please write word or multiple words: '
input = gets.chomp
number_of_characters = input.delete(' ').size
puts "There are #{number_of_characters} characters in \"#{input}\"."

Discussion

We don't want to count spaces here, so we use String#delete to return a
new String with all spaces removed from it. The original string stored
in input is left intact.


TO REVIEW
- String#gsub
- String#delete 


https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-gsub

gsub(pattern, replacement) → new_str
gsub(pattern, hash) → new_str
gsub(pattern) {|match| block } → new_str
gsub(pattern) → enumerator

Returns a copy of str with all occurrences of pattern substituted for the
second argument. The pattern is typically a Regexp; if given as a String,
any regular expression metacharacters it contains will be interpreted
literally, e.g. '\\d' will match a backslash followed by 'd', instead of a digit.

If replacement is a String it will be substituted for the matched text.
It may contain back-references to the pattern's capture groups of the
form \\d, where d is a group number, or \\k<n>, where n is a group name.
If it is a double-quoted string, both back-references must be preceded
by an additional backslash. However, within replacement the special
match variables, such as $&, will not refer to the current match.

If the second argument is a Hash, and the matched text is one of its keys,
the corresponding value is the replacement string.

In the block form, the current match string is passed in as a parameter,
and variables such as $1, $2, $`, $&, and $' will be set appropriately.
The value returned by the block will be substituted for the match on each call.

The result inherits any tainting in the original string or any supplied
replacement string.

When neither a block nor a second argument is supplied, an Enumerator
is returned.

"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  #=> "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"



https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-delete

delete([other_str]+) → new_str click to toggle source

Returns a copy of str with all characters in the **intersection** of its
arguments deleted. Uses the same rules for building the set of characters
as String#count.

"hello".delete "l","lo"        #=> "heo"
"hello".delete "lo"            #=> "he"
"hello".delete "aeiou", "^e"   #=> "hell"
"hello".delete "ej-m"          #=> "ho"

=end