=begin

All Substrings

Write a method that returns a list of all substrings of a string. The
returned list should be ordered by where in the string the substring begins.
This means that all substrings that start at position 0 should come first,
then all substrings that start at position 1, and so on. Since multiple
substrings will occur at each position, the substrings at a given position
should be returned in order from shortest to longest.

You may (and should) use the leading_substrings method you wrote in the
previous exercise:

Examples:

substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]
=end

=begin
Problem
- input: string
- output: a array of leading substrings of the full string, 
          then leading substrings of the substring less the first character
          so on and so forth

Examples
- see above
- requirements:
  - find all leading substrings for string[0..end]
  - find all leading substrings for string[1..end]
  - find all leading substrings for string[-1]
  - Edge case: empty input string, return empty array
  - Assume same treatment and substrings need not be unique even if 
    we have repeated characters e.g, 
    substrings('aaa') == ['a', 'aa', 'aaa',
             'a', 'aa',
             'a'
    ]

Data Structure
- input: string
- output: array of substrings

Algorithm
1. Set curr_index = 0, str_length = string.size, substrings = []
2. While curr_index < str_length
  a. Set curr_string = string.slice(curr_index...length)
  b. call leading_substrings on curr_string, push return value to substrings
  c. curr_index += 1
3. Return substrings.flatten

leading_substrings algorithm
1. Set length = curr_string.size, end_index=0, substrings = []
2. while end_index < length
  a. substrings << curr_string.slice(0..end_index)
  b. end_index += 1
3. Return leading_substrings
=end

def leading_substrings(curr_string)
  length = curr_string.size
  end_index = 0
  substrings = []
  
  while end_index < length
    substrings << curr_string.slice(0..end_index)
    end_index += 1
  end
  
  substrings
end

def substrings(string)
  curr_index = 0
  str_length = string.size
  all_substrings = []
  
  while curr_index < str_length
    substring = string.slice(curr_index...str_length)
    all_substrings << leading_substrings(substring)
    curr_index += 1
  end
  
  all_substrings.flatten
end


p leading_substrings('abcde') == ['a', 'ab', 'abc', 'abcd', 'abcde']

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]


=begin
Solution

def substrings(string)
  results = []
  (0...string.size).each do |start_index|
    this_substring = string[start_index..-1]
    results.concat(leading_substrings(this_substring))
  end
  results
end

Discussion

This problem is a lot easier if you use the leading_substrings method from
the previous exercise. Without that method, it can be really hard to wrap
your head around the requirements and come up with a working solution.

The solution boils down to just repeatedly running leading_substrings on
increasingly smaller substrings of string, starting with the 1st character,
then the 2nd character, and so on. The results are all concatenated to our
results Array which is subsequently returned to the caller.

Our leading_substrings method returns substrings in order from shortest to
longest, and substrings itself works from left to right in the string. Our
results are thus arranged in the desired sequence.
=end

=begin
TO REVIEW
- a..b vs a...b
- we can use the range 0..-1 to slice the full substring
  
    a = "abcde"
    a[0..-1] => "abcde"
    a[4..-1] => "e"
    a[5..-1] => nil (out of range starting index)

- We can use #concat (which is destructive) to ensure all elements are on the
  same level, rather than use << then flatten
- This example is strictly speaking all contiguous substrings, rather than all substrings since "abc" count "ab", 
  "bc" but not "ac" as a substring.
=end