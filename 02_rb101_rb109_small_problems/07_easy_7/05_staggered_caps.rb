=begin

Staggered Caps (Part 1)

Write a method that takes a String as an argument, and returns a new String
that contains the original value using a staggered capitalization scheme in
which every other character is capitalized, and the remaining characters are
lowercase. Characters that are not letters should not be changed, but count
as characters when switching between upper and lowercase.

Example:

staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
staggered_case('ALL_CAPS') == 'AlL_CaPs'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'
=end

=begin
Problem
- input: string
- output: new string with alternate characters capitalized

Examples
- see above
- requirements
  - First character of string should be capitalized
  - consecutive characters in alternate cases
  - Non letters are not changed but it count as characters when switching
    between upper and lowercase
    - e.g. Love Launch -> LoVe iAuNcH

Data Structure
- input: string
- output: new string
- intermediary: array of individual characters

Algorithm
1. Set new_str = ""
2. Iterate through each character with index
3. Switch character
  a. If character is lowercase letter and index is even, then upcase char and append to new_str
  b. If character is uppercase letter and index is odd, then downcase char and append to new_str
  c. else no change to char, append to new_str
4. return new_str
=end

def staggered_case(string)
  new_str = ""
  string.chars.each_with_index do |char, index|
    if char =~ /[a-z]/ && index.even?
      new_str << char.upcase
    elsif char =~ /[A-Z]/ && index.odd?
      new_str << char.downcase
    else
      new_str << char
    end
  end
  
  new_str
end


p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'


=begin
Solution

def staggered_case(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if need_upper
      result += char.upcase
    else
      result += char.downcase
    end
    need_upper = !need_upper
  end
  result
end

Discussion

This solution simply iterates through the String while building another String
one character at a time, either uppercasing or lowercasing each character as
needed. Note that we never need to actually test whether a character is upper-
or lowercase, or even whether it is alphabetic: the upcase and downcase methods
handle this for us.

To keep track of whether we want to upcase or downcase each character, we
define a boolean variable need_upper that starts out as true. Each time we
process a character, we upcase it or downcase it based on the current state
of need_upper. We then toggle need_upper from true to false or false to true
using need_upper = !need_upper.

Further Exploration

Can you modify this method so the caller can request that the first character
be downcased rather than upcased? If the first character is downcased, then the
second character should be upcased, and so on.

Hint: Use a keyword argument.
=end

=begin
TO REVIEW
- and operator is `&&` rather than `&`
- likewise or is `||` rather than `|`
- can use ! to toggle a boolean to make it alternating
- My solution can be further refactored to the following:

   if char =~ /[a-z]/ 
     if index.even?
       new_str << char.upcase
     else
       new_str << char.downcase
     end
   else
     new_str << char
   end
   
=end