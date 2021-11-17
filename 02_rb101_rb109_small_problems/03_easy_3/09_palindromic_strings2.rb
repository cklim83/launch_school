=begin

Palindromic Strings (Part 2)

Write another method that returns true if the string passed as an argument
is a palindrome, false otherwise. This time, however, your method should be
case-insensitive, and it should ignore all non-alphanumeric characters. 
If you wish, you may simplify things by calling the palindrome? method you
wrote in the previous exercise.

Examples:

real_palindrome?('madam') == true
real_palindrome?('Madam') == true           # (case does not matter)
real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
real_palindrome?('356653') == true
real_palindrome?('356a653') == true
real_palindrome?('123ab321') == false

=end

=begin
Problem
- input: String
- output: Boolean

Other requirements/Clarifying questions
- only alphanumeric matters. spaces, punctuation ignored based on 3rd example
- case does not matters based on second example
- What should the method return if given an empty string? Assume true

Examples
- See above

Algorithm
- 1) Preprocess input string by downcases and keeping on alphanumeric characters
- 2) set two indices: front = 0  and back = length of string - 1
- 3) check that front is >= back, break if false 
- 4) compare the characters at these 2 string locations. Return false if the are different
- 5) increment front and decrement back and loop back to step 3
- 6) Return true

=end

def palindrome?(sentence)
  front = 0
  back = sentence.size - 1
  
  loop do
    break unless front <= back
    return false if sentence[front] != sentence[back]
    front += 1
    back -= 1
  end
  
  true
end

def process_string(sentence)
  # downcase and remove non-alphanumeric characters, 
  # /i is option to ignore case but not needed in this case (https://ruby-doc.org/core-2.5.1/Regexp.html ctr+f /i)
  sentence.downcase.gsub(/[^0-9a-z]/, '') 
end

def real_palindrome?(sentence)
  processed_string = process_string(sentence)
  palindrome?(processed_string)
end


p process_string("Madam, I'm -  ' Adam")
p real_palindrome?('madam') == true
p real_palindrome?('Madam') == true           # (case does not matter)
p real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
p real_palindrome?('356653') == true
p real_palindrome?('356a653') == true
p real_palindrome?('123ab321') == false


=begin

Solution

def real_palindrome?(string)
  string = string.downcase.delete('^a-z0-9')
  palindrome?(string)
end

Discussion

Chances are you reached for a String#gsub here to eliminate the 
non-alphanumeric characters. There's nothing wrong with that, but
we'll take the opportunity to use and talk about String#delete instead.
#delete is an interesting method that takes arguments that sort of look
like regular expressions, and then deletes everything formed by the
intersection of all its arguments. See the documentation for complete
details.

For our purposes, we need to remove the non-alphanumeric characters;
to do that, we tell delete to delete everything that isn't a letter
or digit. We then pass the result to our original palindrome? method
to determine if the cleaned up string is a palindrome.

Further Exploration

Read the documentation for String#delete, and the closely related
String#count (you need to read count to get all of the information
you need for delete.)

TO REVIEW: 
- String#delete
- String#count


https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-delete

delete([other_str]+) → new_str

Returns a copy of str with all characters in the intersection of
its arguments deleted. Uses the same rules for building the set
of characters as String#count.

"hello".delete "l","lo"        #=> "heo"
"hello".delete "lo"            #=> "he"
"hello".delete "aeiou", "^e"   #=> "hell"
"hello".delete "ej-m"          #=> "ho"


https://docs.ruby-lang.org/en/2.6.0/String.html#method-i-count

count([other_str]+) → integer

Each other_str parameter defines a set of characters to count.
The intersection of these sets defines the characters to count
in str. Any other_str that starts with a caret ^ is negated.
The sequence c1-c2 means all characters between c1 and c2. The
backslash character \ can be used to escape ^ or - and is otherwise
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