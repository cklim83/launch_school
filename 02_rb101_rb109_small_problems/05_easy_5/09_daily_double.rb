=begin

ddaaiillyy ddoouubbllee

Write a method that takes a string argument and returns a new string that
contains the value of the original string with all consecutive duplicate
characters collapsed into a single character. You may not use
String#squeeze or String#squeeze!.

Examples:

crunch('ddaaiillyy ddoouubbllee') == 'daily double'
crunch('4444abcabccba') == '4abcabcba'
crunch('ggggggggggggggg') == 'g'
crunch('a') == 'a'
crunch('') == ''

=end

=begin
Problem:
- input: string of words
- output: string with consecutive duplicate characters collapsed into
          a single character
          
Examples:
- see above
- charcters can be alphanumeric (inferred)
- Assume we should deduplicate non-alphanumeric e.g. spaces or 
  special characters?
- Edge case: return empty string if input is empty string
- Assume it is case sensitive i.e. "Gg" returns "Gg" rather than "g"

Data Structure
- input: String
- output: String
- intermediary: Likely an array of characters

Algorithm
1 - Create an empty clean_char array
2 - Split input string into array of characters
3 - For each character, push into clean_char if current char != clean_char.last
4 - Join the elements without space and result result

=end

def crunch(text)
  clean_char = []
  text.chars.each do |char|
    clean_char << char unless clean_char.last == char
  end
  clean_char.join('')
end

p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''


=begin

Solution

def crunch(text)
  index = 0
  crunch_text = ''
  while index <= text.length - 1
    crunch_text << text[index] unless text[index] == text[index + 1]
    index += 1
  end
  crunch_text
end

Discussion

This one isn't too bad. We have to go through each character of this string
and check for any consecutive duplicate characters. The plan is to build the
return value, character by character, in the string referenced by crunch_text.
With that in mind, we use index to track our position in text.

On each iteration of our loop, we check whether the current indexed character
is equal to the next character in text. If the characters are the same, we do
nothing but advance the index to the next character in text. Otherwise, we
append the current character to crunch_text and increment the index.

Further Exploration

You may have noticed that we continue iterating until index points past the
end of the string. As a result, on the last iteration text[index] is the last
character in text, while text[index + 1] is nil. Why do we do this? What
happens if we stop iterating when index is equal to text.length?

My answer: 
need to iterate beyond the last character to ensure last character can also
be included. Ok to iterate to index = text.length since last iteration
text[length] == text[length+1] == nil which will prevent nil from being
included in result.

Can you determine why we didn't use String#each_char or String#chars to
iterate through the string? How would you update this method to use
String#each_char or String#chars?

My answer: 
We are currently comparing consecutive characters on text. Using String#chars
or String#each_char will only give us access to one character at a time.

You can solve this problem using regular expressions (see the Regexp class
documentation). For a fun challenge, give this a try with regular expressions.
If you haven't already read our book, Introduction to Regular Expressions, you
may want to keep it handy if you try this challenge.

Can you think of other solutions besides regular expressions?
=end

# Further Explore, using regex from student solutions

def crunch_regex(string)
  string.gsub(/(.)\1+/, '\1')
end

p crunch_regex('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch_regex('4444abcabccba') == '4abcabcba'
p crunch_regex('ggggggggggggggg') == 'g'
p crunch_regex('a') == 'a'
p crunch_regex('') == ''

=begin
I'll break this down, without going into too much detail:

First argument into #gsub:

    (.) defines a capture group. This is simply a group of character(s) that
    we can reference in our Regex. This capture group matches any character,
    because of the '.'.
    
    \1 defines a reference. This allows us to reference the capture group we
    defined (more on this in a sec).
    
    + is a quantifier that allows us to match "one or more" of the preceding
    capture group (in this case, one or more of a given character).
    Effectively, this first argument matches any consecutive sequence of the
    same characters, and simultaneously defines a capture group referenced by \1.

Second argument into #gsub:

    The second argument in String#gsub, made explicit by the Ruby docs, is
    a replacement string. Aside from being able to contain characters to use
    as a replacement, replacement strings can contain back-references.
    Our replacement string contains the back-reference \1, which will evaluate
    to the character used in our capture group.

Summary: Every match from the first argument (consecutive sequence) is replaced
by the single character we captured and then back-referenced. This has the 
intended effect.


TO REVIEW:
- regex
- String[out_of_range_index] returns nil rather than raise an error
- Comparing consecutive characters using loop and index 

=end