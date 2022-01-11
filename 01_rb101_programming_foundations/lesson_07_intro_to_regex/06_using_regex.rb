=begin
Write a method that returns true if its argument looks like a URL, false if it does not.

Examples:

Ruby

url?('http://launchschool.com')   # -> true
url?('https://example.com')       # -> true
url?('https://example.com hello') # -> false
url?('   https://example.com')    # -> false
=end

def url?(string)
  # !!string.match(/\Ahttps?:\/\/\S*\z/)
  !!(string =~ /\Ahttps?:\/\/\S*\z/)
end

p url?('http://launchschool.com') == true
p url?('https://example.com') == true
p url?('https://example.com hello') == false
p url?('   https://example.com') == false

=begin
Solution:

Ruby

def url?(text)
  !!text.match(/\Ahttps?:\/\/\S+\z/)
end

or

def url?(text)
  text.match?(/\Ahttps?:\/\/\S+\z/)
end

Note that we use !! to coerce the result of our match call to a boolean value.
More recent Ruby versions add the String.match? method, which we demonstrate
in our second Ruby solution.


TO REVIEW:
- We use string rather than line anchors
=end


=begin
Write a method that returns all of the fields in a haphazardly formatted string.
A variety of spaces, tabs, and commas separate the fields, with possibly multiple
occurrences of each delimiter.

Examples:

Ruby

fields("Pete,201,Student")
# -> ["Pete", "201", "Student"]

fields("Pete \t 201    ,  TA")
# -> ["Pete", "201", "TA"]

fields("Pete \t 201")
# -> ["Pete", "201"]

fields("Pete \n 201")
# -> ["Pete", "\n", "201"]
=end

# Possible delimiters are: `,`, and whitespaces such as`\t`, spaces. Note we want to 
# retain \n (last test example) so we cant use \s directly which would have included \n

def fields(string)
  string.split(/[,\t ]+/)
end

p fields("Pete,201,Student") == ["Pete", "201", "Student"]

p fields("Pete \t 201    ,  TA") == ["Pete", "201", "TA"]

p fields("Pete \t 201") == ["Pete", "201"]

p fields("Pete \n 201") == ["Pete", "\n", "201"]

=begin
Solution

def fields(str)
  str.split(/[ \t,]+/)
end

Note that we don't use \s here since we want to split at spaces and tabs, not other whitespace characters.

TO REVIEW
- tried /[,\t ]/ which yielded
  
  ["Pete", "201", "Student"]
  ["Pete", "", "", "201", "", "", "", "", "", "", "TA"] not sure why
  ["Pete", "", "", "201"]
  ["Pete", "\n", "201"]

- tried  /[,\t ]*/ which yielded ["P", "e", "t", "e", "2", "0", "1", "T", "A"]  for "Pete \t 201    ,  TA"
=end


=begin
Write a method that changes the first arithmetic operator (+, -, *, /)
in a string to a '?' and returns the resulting string. Don't modify the original string.

Examples:

Ruby

mystery_math('4 + 3 - 5 = 2')
# -> '4 ? 3 - 5 = 2'

mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'
=end


def mystery_math(string)
  string.sub(/[+\-*\/]/, '?')
end

p mystery_math('4 + 3 - 5 = 2') == '4 ? 3 - 5 = 2'

p mystery_math('(4 * 3 + 2) / 7 - 1 = 1') == '(4 ? 3 + 2) / 7 - 1 = 1'


=begin
Solution:

Ruby

def mystery_math(equation)
  equation.sub(/[+\-*\/]/, '?')
end

Note that we need to escape the - character in our character class to interpret as a literal hyphen,
not a range specification. We also must escape the / character in the Ruby code; in the JavaScript
code, we don't need to escape the / character but do so here for consistency.


TO REVIEW
- my original answer: string.sub(/[+-*/]/, '?')
- sub will only replace the first occurrence of match and return a new string
  so suit the need of this problem 
- Assume that + - * / within square brackets are not meta-characters but
  this understanding is wrong. - in [] meant range hence error indicated empty range in char class
  This will be solved with escaping, similarly / also need escaping
- changing to string.sub(/[+\-*\/]/, '?') solves the problem
=end


=begin
Write a method that changes every arithmetic operator (+, -, *, /) to a '?' and
returns the resulting string. Don't modify the original string.

Examples:

Ruby

mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'
=end

def mysterious_math(string)
  string.gsub(/[+\-*\/]/, '?')
end

p mysterious_math('4 + 3 - 5 = 2') == '4 ? 3 ? 5 = 2'
p mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') == '(4 ? 3 ? 2) ? 7 ? 1 = 1'


=begin
Solution
Ruby

def mysterious_math(equation)
  equation.gsub(/[+\-*\/]/, '?')
end

Note that we now use the gsub method in Ruby, and apply the g option to the regex in JavaScript.


TO REVIEW
- gsub will replacement every occurrence and return a new string
=end


=begin
Write a method that changes the first occurrence of the word apple,
blueberry, or cherry in a string to danish.

Examples:

Ruby

danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

danish('The cherry of my eye')
# -> 'The danish of my eye'

danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

danish('I love pineapple')
# -> 'I love pineapple'
=end

def danish(string)
  string.sub(/\b(apple|blueberry|cherry)\b/, 'danish')
end

p danish('An apple a day keeps the doctor away') == 'An danish a day keeps the doctor away'

p danish('My favorite is blueberry pie') == 'My favorite is danish pie'

p danish('The cherry of my eye') == 'The danish of my eye'

p danish('apple. cherry. blueberry.') == 'danish. cherry. blueberry.'

p danish('I love pineapple') == 'I love pineapple'


=begin
Solution:
Ruby

def danish(text)
  text.sub(/\b(apple|blueberry|cherry)\b/, 'danish')
end

Note that pineapple is not changed in the last example for each language.


TO REVIEW
- use simple concatenation for the words then alternation
- use sub to replace only first occurrence which will handle example 4
- \b word boundary needed to handle last example
=end


=begin
Challenge: write a method that changes strings in the date format 2016-06-17
to the format 17.06.2016. You must use a regular expression and should use
methods described in this section.

Example:

Ruby

format_date('2016-06-17') # -> '17.06.2016'
format_date('2016/06/17') # -> '2016/06/17' (no change)
=end

def format_date(string)
  string.sub(/\A(\d{4})-(\d{2})-(\d{2})\z/, '\3.\2.\1')
end

p format_date('2016-06-17') == '17.06.2016'
p format_date('2016/06/17') == '2016/06/17'


=begin
Solution:
Ruby

def format_date(original_date)
  original_date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1')
end

We use three capture groups here to capture the year, month, and date,
then use them in the replacement string in reverse order, this time
separated by periods instead of hyphens.


TO REVIEW
- Requirement to only rearrange dates with `-` separator, so I
  tried to ensure there is a match only if the entire string matches, then
  use capture groups to change the order.
  
- \A and \z is to restrict the match to start and end of string to make it tighter.
=end


=begin
Challenge: write a method that changes dates in the format 2016-06-17 or 2016/06/17
to the format 17.06.2016. You must use a regular expression and should use methods
described in this section.

Example:

Ruby

format_date('2016-06-17') # -> '17.06.2016'
format_date('2017/05/03') # -> '03.05.2017'
format_date('2015/01-31') # -> '2015/01-31' (no change)
=end

def format_date(string)
  string.sub(/\A(\d{4})([\-\/])(\d{2})\2(\d{2})\z/, '\4.\3.\1')
end

p format_date('2016-06-17') == '17.06.2016'
p format_date('2017/05/03') == '03.05.2017'
p format_date('2015/01-31') == '2015/01-31'


=begin
Solution:
Ruby

def format_date(original_date)
  original_date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1')
               .sub(/\A(\d\d\d\d)\/(\d\d)\/(\d\d)\z/, '\3.\2.\1')
end

Alternate solution

def format_date(original_date)
  date_regex = /\A(\d\d\d\d)([\-\/])(\d\d)\2(\d\d)\z/
  original_date.sub(date_regex, '\4.\3.\1')
end

JavaScript

let formatDate = function (originalDate) {
  return originalDate.replace(/^(\d\d\d\d)-(\d\d)-(\d\d)$/, '$3.$2.$1')
                     .replace(/^(\d\d\d\d)\/(\d\d)\/(\d\d)$/, '$3.$2.$1');
};

Alternate solution

let formatDate = function (originalDate) {
  let dateRegex = /^(\d\d\d\d)([\-\/])(\d\d)\2(\d\d)$/;
  return originalDate.replace(dateRegex, '$4.$3.$1');
};

The easiest way to approach this problem is to split it into smaller sub-problems, 
one that handles dates in 2016-05-17 format, and one that handles 2016/05/17 format,
which is what both of our primary solutions do. One possible gotcha here is that you
must remember to escape the / characters in the regex.

You can solve this problem with one regex, as in our alternate solutions, but at the
expense of a more complex regex and lowered readability. The regex adds one additional
capture group to capture the first - or /, and uses a \2 backreference to refer back
to that capture in the regex. However, this additional capture group modifies the
backreference numbers for the month and day components of the date, so we now need to
refer to them as \4 and \3 in Ruby, $4 and $3 in JavaScript. In Ruby, this might be a
good time to look up how to use named capture groups.

Note that our alternate solutions use variables to store the regex. We do this both
for readability, and to show that regex are no different than any other object; you
can manipulate and pass them around as needed.

TO REVIEW
 - Use capture group to store the match which could be `-` or `/`, the use backreference
   in the latter part of same regex to ensure it is the same separator if we were to have 
   a match. Then use capture group to rearrange the order.
 - However, this solution is not very readable and preferable to break it down to two matches (see suggested solution).
   My initial attempt is wrong
   
   if string.match(/\A(\d{4})-(\d{2})-(\d{2})\z/) || string.match(/\A(\d{4})\/(\d{2})\/(\d{2})\z/)
     '\3\2\1'
   end
    
   Will return \3\2\1 
 
=end