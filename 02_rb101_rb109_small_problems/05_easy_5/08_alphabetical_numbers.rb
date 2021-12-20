=begin

Alphabetical Numbers

Write a method that takes an Array of Integers between 0 and 19, and returns
an Array of those Integers sorted based on the English words for each number:

zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven,
twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen

Examples:

alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]

=end

=begin
Problem
- input: Array of Integers between 0 and 19 inclusive
- output: Integers sorted based on their english spelling

Example
- See above
- English spelling are in lower cases

Data Structure
- input: Array
- output: Array

Algorithm
1 - Map each integer to its English word using a hash
2 - Use sort_by
=end

ZERO_TO_NINETEEN_MAP = {
  0 => 'zero',
  1 => 'one',
  2 => 'two',
  3 => 'three',
  4 => 'four',
  5 => 'five',
  6 => 'six',
  7 => 'seven',
  8 => 'eight',
  9 => 'nine',
  10 => 'ten',
  11 => 'eleven',
  12 => 'twelve',
  13 => 'thirteen',
  14 => 'fourteen',
  15 => 'fifteen',
  16 => 'sixteen',
  17 => 'seventeen',
  18 => 'eighteen',
  19 => 'nineteen'
}


def alphabetic_number_sort(integers)
  integers.sort_by { |num| ZERO_TO_NINETEEN_MAP[num] }
end

p alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]



=begin

Solution

NUMBER_WORDS = %w(zero one two three four
                  five six seven eight nine
                  ten eleven twelve thirteen fourteen
                  fifteen sixteen seventeen eighteen nineteen)

def alphabetic_number_sort(numbers)
  numbers.sort_by { |number| NUMBER_WORDS[number] }
end

Solution

The secret to solving this problem is to use a data structure of some kind
to map numbers to their English names. Once you've done this, read the
documentation for Enumerable#sort_by, and construct a call that sorts the
numbers by each number's corresponding English name.

Further Exploration

Why do you think we didn't use Array#sort_by! instead of Enumerable#sort_by?

My answer: 
We do not want to mutate the original integer array as method 
name suggest it is non-mutating

For an extra challenge, rewrite your method to use Enumerable#sort 
(unless you already did so).

=end

def alphabetic_number_sort2(integers)
  integers.sort_by!{ |a| ZERO_TO_NINETEEN_MAP[a] }
end

numbers = (0..19).to_a
p alphabetic_number_sort2(numbers)
p numbers

=begin

TO REVIEW
- Hash initialization: Note that integers cannot be use as symbols unlike strings. 
  :0 raise the following error:
  SyntaxError ((irb):7: syntax error, unexpected tINTEGER, expecting tSTRING_CONTENT or
  tSTRING_DBEG or tSTRING_DVAR or tSTRING_END)
  - Hence { 0: 'zero' } will results in an error. Instead we should write { 0 => 'zero' }

To Check
- Methods of Array and Enumerables:
  - Array#sort, Array#sort!, Array#sort_by!
  - Enumerable#sort, Enumerable#sort_by
- Question: [1, 2].sort, are we calling Array#sort or Enumerable#sort? Are there differences?

=end