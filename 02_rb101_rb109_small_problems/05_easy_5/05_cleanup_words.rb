=begin

Clean up the words

Given a string that consists of some words (all lowercased) and an assortment
of non-alphabetic characters, write a method that returns that string with all
of the non-alphabetic characters replaced by spaces. If one or more
non-alphabetic characters occur in a row, you should only have one space in the
result (the result should never have consecutive spaces).

Examples:

cleanup("---what's my +*& line?") == ' what s my line '

=end

=begin
Problem
- input: String of lowercase characters interspersed with 
         non-alphabetic characters
- out: String with non-alphabetic characters replaced with space

Example
- See above
- no consecutive spaces

Data Structure
- input: String
- output: String

Algorithm
1 - find and replace all non-alphabetic characters with space
2 - find contiguous space characters (1 or more) and replace with single space 
    using gsub and regex greedy matching

=end

def cleanup(sentence)
  alphabets = ("a".."z").to_a
  index = 0
  
  loop do
    break if index >= sentence.size
    sentence[index] = " " unless alphabets.include?(sentence[index])
    index += 1
  end
  
  sentence.gsub(/[' ']+/, " ")
end


p cleanup("---what's my +*& line?") == ' what s my line '


=begin

Solution

Solution 1

ALPHABET = ('a'..'z').to_a

def cleanup(text)
  clean_chars = []

  text.chars.each do |char|
    if ALPHABET.include?(char)
      clean_chars << char
    else
      clean_chars << ' ' unless clean_chars.last == ' '
    end
  end

  clean_chars.join
end

Solution 2

def cleanup(text)
  text.gsub(/[^a-z]/, ' ').squeeze(' ')
end

Discussion

Our first solution is straightforward. We begin by initializing a constant
to contain an array of all the letters in the alphabet. The letters of the
English alphabet are not meant to change, so this is a good use case for a
constant. Note our use of a range to get all lowercase alphabetical
characters between 'a' and 'z'. We can then convert the range into an array
and have access to useful array methods like include?.

Inside our method we iterate over all the characters of the original string.
We use a conditional statement to append a character to the clean_chars array
if it is included in the alphabet, and a space otherwise. Notice also that we
use an unless clause to avoid including superfluous spaces in the final string.

While this first solution is perfectly fine, using regular expressions can
sometimes really help with messy text manipulation, as illustrated by the
second solution. They aren't always the wisest choice for understandable code,
but they can save a lot of effort in some cases. You don't have to be familiar
with regular expressions at this stage, but a little knowledge can go a long way.

This method is quite simple: using the gsub call, it simply replaces all
non-alphabetic characters in text with a space, then squeezes out all of the
duplicate spaces. (The squeeze call could be replaced by another gsub call,
but squeeze is easier to understand at a glance.)

If you are unfamiliar with regular expressions, the expression /[^a-z]/ is a
regular expression that matches any character that is not a lowercase letter.
gsub replaces all characters in text that match the regular expression in the 
1st argument with the value in the 2nd argument.

Note that in both our solutions we are returning a new string object. If you
are unsure after reading a problem description whether you should return a new
string object or the same one, that would be a great question to ask an
interviewer.

TO REVIEW
- String#squeeze
- How to not add duplicate spaces without using two indices
- regex
- Ask interviewew if solution should return a new object or mutate the original

https://docs.ruby-lang.org/en/master/String.html#method-i-squeeze
squeeze([other_str]*) → new_str

Builds a set of characters from the other_str parameter(s) using the procedure
described for String#count (see below). Returns a new string where runs of the
same character that occur in this set are replaced by a single character. If no
arguments are given, all runs of identical characters are replaced by a single
character.

"yellow moon".squeeze                  #=> "yelow mon"
"  now   is  the".squeeze(" ")         #=> " now is the"
"putters shoot balls".squeeze("m-z")   #=> "puters shot balls" # set of characters from m to z


https://docs.ruby-lang.org/en/master/String.html#method-i-count

count([other_str]+) → integer

Each other_str parameter defines a set of characters to count. The intersection
of these sets defines the characters to count in str. Any other_str that starts
with a caret ^ is negated. The sequence c1-c2 means all characters between c1
and c2. The backslash character \ can be used to escape ^ or - and is otherwise
ignored unless it appears at the end of a sequence or the end of a other_str.

a = "hello world"
a.count "lo"                   #=> 5
a.count "lo", "o"              #=> 2
a.count "hello", "^l"          #=> 4
a.count "ej-m"                 #=> 4

"hello^world".count "\\^aeiou" #=> 4
"hello-world".count "a\\-eo"   #=> 4

c = "hello world\\r\\n"
c.count "\\"                   #=> 2
c.count "\\A"                  #=> 0
c.count "X-\\w"                #=> 3


=end