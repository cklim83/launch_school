=begin

Matching Parentheses?

Write a method that takes a string as an argument, and returns true if all
parentheses in the string are properly balanced, false otherwise. To be
properly balanced, parentheses must occur in matching '(' and ')' pairs.

Examples:

balanced?('What (is) this?') == true
balanced?('What is) this?') == false
balanced?('What (is this?') == false
balanced?('((What) (is this))?') == true
balanced?('((What)) (is this))?') == false
balanced?('Hey!') == true
balanced?(')Hey!(') == false
balanced?('What ((is))) up(') == false

Note that balanced pairs must each start with a (, not a ).
=end

=begin
Problem
- input: a string
- output: boolean, depending on whether string has matching parentheses

Examples
- requirements
  - matching parentheses meaning number of '(' equals number of ')' in the string
    - balanced?('What (is) this?') == true
    - balanced?('What is) this?') == false
    - balanced?('What (is this?') == false
    - balanced?('((What) (is this))?') == true
    - balanced?('((What)) (is this))?') == false
  - No of '()' can be zero
    - balanced?('Hey!') == true
  - The order of "()" is important, "(" should come before ")"
    - balanced?(')Hey!(') == false
    - balanced?('What ((is))) up(') == false
  - Assume "" returns true as it falls under the zero '()' category
  

Data Structure
- input: string
- output: boolean
- intermediary: can be an array to store the parentheses

Algorithm
- Set open_parentheses = []
- Iterate through each character of input string
  - If char == '(', push char into open_parentheses
  - Else if char = ')', pop open_parentheses and check if it is == '('
    - If false return false
- return true if open_parentheses is empty
=end

def balanced?(string)
  open_parentheses = []
  string.each_char do |char|
    if char == '('
      open_parentheses << char
    elsif char == ')'
      result = open_parentheses.pop # return nil if no '(' in open_parentheses
      return false unless result
    end
  end
  
  open_parentheses.empty?
end


p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false


=begin
Solution

def balanced?(string)
  parens = 0
  string.each_char do |char|
    parens += 1 if char == '('
    parens -= 1 if char == ')'
    break if parens < 0
  end

  parens.zero?
end

Discussion

This is one problem that seems very difficult, but is actually quite easy
to solve. A string is balanced if for each left parenthesis we have a matching
right parenthesis.

We can keep track of this by keeping a tally of the total parentheses count.
Left parentheses are +1 and right parentheses are -1. If our string is
balanced, then the total, parens will always be zero after parsing string.

Notice how we have break if parens < 0. This is used to account for cases
where a right parenthesis occurs before a left parenthesis, and that right
parenthesis doesn't have a matching left parenthesis.

Here is an example: balanced?(')Hey!('). If we should ever have a negative
value for parens, then we know that our left and right parentheses are
reversed, and that this isn't a balanced string.

Further Exploration

There are a few other characters that should be matching as well. Square
brackets and curly brackets normally come in pairs. Quotation marks(single
and double) also typically come in pairs and should be balanced. Can you
expand this method to take into account those characters?
=end


=begin
TO REVIEW
- [].pop returns nil
- Array#empty?
- Use array as a stack to push and pop to check if () are matching and in order.
-end
  