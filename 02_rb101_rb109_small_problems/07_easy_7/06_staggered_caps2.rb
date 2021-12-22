=begin

Staggered Caps (Part 2)

Modify the method from the previous exercise so it ignores non-alphabetic
characters when determining whether it should uppercase or lowercase each
letter. The non-alphabetic characters should still be included in the return
value; they just don't count when toggling the desired case.

Example:

staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
staggered_case('ALL CAPS') == 'AlL cApS'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'
=end

=begin
Problem
- input: string
- output: new string, with cases of letter characters alternated, the first letter 
          should be capitalized. Non-letter characters not counted in case alternation

Examples
- see above
- requirements
  - first letter in caps ("ignore" -> "IgNoRe")
  - non-letters not included in alternation count
  e.g. "I Love" -> "I lOvE"

Data Structure
- input: string
- output: new string

Algorithm
1. Set to_cap = true, new_str = ""
2. Iterate through each character in string
  a. if character is letter and to_cap == true, upcase char and append to new_str, toggle to_cap 
  b. elsif character is letter and to_cap == false, downcase char and append to new_str, toggle to_cap
  c. else append char to new_str
3. return new_str
=end

def staggered_case(string)
  new_str = ""
  to_cap = true
  string.chars.each do |char|
    if char =~ /[A-Za-z]/ && to_cap
      new_str << char.upcase
      to_cap = !to_cap
    elsif char =~ /[A-Za-z]/ && (!to_cap)
      new_str << char.downcase
      to_cap = !to_cap
    else
      new_str << char
    end
  end
  
  new_str
end


p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'


=begin
Solution

def staggered_case(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if char =~ /[a-z]/i
      if need_upper
        result += char.upcase
      else
        result += char.downcase
      end
      need_upper = !need_upper
    else
      result += char
    end
  end
  result
end

Discussion

This solution is very similar to the previous solution; the only difference is
that we need to avoid changing need_upper when processing non-alphabetic
characters. We use a simple regular expression with the /i flag (ignore case)
to detect letters.

Further Exploration

Modify this method so the caller can determine whether non-alphabetic characters
should be counted when determining the upper/lowercase state. That is, you want
a method that can perform the same actions that this method does, or operates
like the previous version.

Hint: Use a keyword argument.
=end

=begin
TO REVIEW
- regex: i flag to make the comparison case insensitive
  - char =~ /[a-z]/i 
  
- my solution can be further refactored to given solution i.e. nested if conditions
  to reduce the number of conditional comparisons.  
=end

