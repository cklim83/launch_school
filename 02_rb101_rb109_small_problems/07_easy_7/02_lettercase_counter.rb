=begin

Lettercase Counter

Write a method that takes a string, and then returns a hash that contains
3 entries: one represents the number of characters in the string that are
lowercase letters, one the number of characters that are uppercase letters,
and one the number of characters that are neither.

Examples

letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }
=end

=begin
Problem
- input: string
- output: hash with 3 key-value pairs
          - :lowercase => occurrences
          - :uppercase => occurrences
          - :neither => occurrences

Examples
- see above
- requirements
  - String can contain any character types: alphanumeric, spaces, signs, special characters
  - numeric and space consider under :neither count
  - + sign is under :neither count as well
  - Even if occurrence is 0, the key should be in the hash to be returned
  - input string can be an empty string, then the return value is all 0
  - hash key order: lowercase, uppercase, neither
  
Data Structures
- input: string
- output: hash

Algorithm
1. Initialize char_type_hsh to { lowercase: 0, uppercase: 0, neither: 0 }
2. Iterate through each character
    when character in a..z, then increment lowercase value
    when character in A..Z, then increment uppercase value
    else increment neither value
3. return char_type_hsh
=end

def letter_case_count(string)
  char_type_hsh = { lowercase: 0, uppercase: 0, neither: 0 }
  
  string.each_char do |char|
    case char
    when 'a'..'z' then char_type_hsh[:lowercase] += 1
    when 'A'..'Z' then char_type_hsh[:uppercase] += 1
    else char_type_hsh[:neither] += 1
    end
  end
  
  char_type_hsh
end


p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }


=begin
Solution

Solution 1

UPPERCASE_CHARS = ('A'..'Z').to_a
LOWERCASE_CHARS = ('a'..'z').to_a

def letter_case_count(string)
  counts = { lowercase: 0, uppercase: 0, neither: 0 }

  string.chars.each do |char|
    if UPPERCASE_CHARS.include?(char)
      counts[:uppercase] += 1
    elsif LOWERCASE_CHARS.include?(char)
      counts[:lowercase] += 1
    else
      counts[:neither] += 1
    end
  end

  counts
end

Solution 2

def letter_case_count(string)
  counts = {}
  characters = string.chars
  counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }
  counts[:uppercase] = characters.count { |char| char =~ /[A-Z]/ }
  counts[:neither] = characters.count { |char| char =~ /[^A-Za-z]/ }
  counts
end

Discussion

This method is expected to return a hash of character counts.

In the first solution, we begin by initializing two constants containing the
uppercase and lowercase letters of the alphabet. Then, after initializing a
counts hash with the appropriate keys and default values of zero, we simply
iterate over each character of the string passed in as an argument and update
each count as needed.

We take a different approach in our second solution. We first initialize an
empty counts hash and then use Array#count to find the number of occurrences
of lowercase, uppercase, and all other characters. In the block following the
count method invocation, we use the String#=~ method to match each character
of the string against a pattern specified by a regular expression. The block
will return a truthy value if there is a match, nil otherwise.

In the second solution, we use regular expressions to count certain types of
characters. We'll explain things a bit here for those who aren't familiar with
regex:

char =~ /[a-z]/ : This checks if the character is a lowercase letter between a
and z. char =~ /[A-Z]/ : This checks if the character is an uppercase letter
between A and Z. char =~ /[^A-Za-z]/ : This checks if the character is neither
an uppercase letter nor a lowercase letter.

For more information on regex, see our book, Introduction to Regular
Expressions. We'll ask you to read the book later, but you can skim it at any time.
=end

=begin
To REVIEW
- remember that case statement below is equivalent to char in 'a'..'z' etc
  case char
  when 'a'..'z' then char_type_hsh[:lowercase] += 1
  when 'A'..'Z' then char_type_hsh[:uppercase] += 1
  else char_type_hsh[:neither] += 1
  end
  
- review Array#count accepting a block
- Regex
  - characters.count { |char| char =~ /[a-z]/ }
  - char =~ /[a-z]/ meant char matches anything in 'a'..'z'
  - char =~ /[A-Z]/ meant char matches anything in 'A'..'Z'
  - char =~ /[^A-Za-z]/ meant char matches anything in 'a'..'z'
  - review meaning of `=~`
=end