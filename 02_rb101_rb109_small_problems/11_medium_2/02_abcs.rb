=begin

Now I Know My ABCs

A collection of spelling blocks has two letters per block, as shown in this
list:

B:O   X:K   D:Q   C:P   N:A
G:T   R:E   F:S   J:W   H:U
V:I   L:Y   Z:M

This limits the words you can spell with the blocks to just those words that
do not use both letters from any given block. Each block can only be used once.

Write a method that returns true if the word passed in as an argument can be
spelled from this set of blocks, false otherwise.

Examples:

block_word?('BATCH') == true
block_word?('BUTCH') == false
block_word?('jest') == true
=end

=begin
Problem
- input: a word
- output: true or false, depending on whether the input word can be spelled from set of blocks.

Examples
- requirements
  - to return true, a block can only be used once
  - input word can be lower or uppercase and the method has to be case insensitive
  - assume input is a single word consisting of only alphabets

Data Structure
- input: string
- output: boolean
- intermediary: nested array storing the blocks

Algorithm
1. set blocks = ['B:O', 'X:K' ... 'Z:M'], word_block_indices = []
2. Iterate through each character of input string with a block
  a. Within block, iterate through each character_pair_string in block
      if character_pair_string contains character.upcase, store the index of that pair in word_block_indices
3. Return true if the number of unique indices in word_block_indices == size of input string, else return false
=end

def block_word?(word)
  block = %w(B:O   X:K   D:Q   C:P   N:A
             G:T   R:E   F:S   J:W   H:U
             V:I   L:Y   Z:M)
  block_index = []
  
  word.each_char do |char|
    block.each_with_index do |pair, index|
      if pair.include?(char.upcase)
        block_index << index
      end
    end
  end
  
  block_index.uniq.size == word.size
end

p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true


=begin
Solution

BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze

def block_word?(string)
  up_string = string.upcase
  BLOCKS.none? { |block| up_string.count(block) >= 2 }
end

Discussion

The first thing we want to consider is how we should organize our blocks;
we want to be able to check each block easily to make sure that a valid
block word is passed to this method.

For this solution, we'll use an array of two letter strings. We'll use
this array to check that the word passed in doesn't contain two letters
from any block. We also want to make sure that no block is used more than
once. If both those conditions are met, then we have a valid block word.

In the solution the String#count method is used. This allows us to count
the number of occurrences of a collection of characters. The collection
of characters will be each block we want to check. If we find a count of
2 or greater, then we know that either both block characters are contained
within the string, or that a character from the current block occurs more
than once in that string.

The final item of note is that we must convert the input string to uppercase,
just in case it contains lowercase letters.

Further Exploration

Did you use a different data structure for organizing your blocks? Were those
blocks 2 letter strings or something else? What method did you use to check if
a string had 2 letters from a single block? There are several different
possibilities for solving this exercise.
=end


=begin
TO REVIEW
- Array#uniq
- Why my original algorithm below will not work
  
  1. set constant BLOCK_PAIRS = [['B', 'O'], ['X', 'K'] ... ['Z', 'M']]
  2. Iterate through each character of string with a block
    a. Iterate through each element in block_pairs
        if element contains character.upcase, delete element, exit inner loop
        else return false # if the first element does not contain the char, this will return false. But 
                          # the character can be in later elements
  3. Return true
  
- Learn how to use another array to track indices or values like in my solution rather than mutating the array
  i am iterating over.
- Learn how to use dup to create a copy for mutation, while iterating over the original
=end