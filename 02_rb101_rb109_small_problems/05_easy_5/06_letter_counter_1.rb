=begin

Letter Counter (Part 1)

Write a method that takes a string with one or more space separated words
and returns a hash that shows the number of words of different sizes.

Words consist of any string of characters that do not include a space.

Examples

word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
word_sizes('') == {}

=end

=begin

Problem
- input: String of 1 or more words separated by space
- output: Hash with word_length as keys and occurrences as values

Example
- See above
- Contiguous blocks of non spaces characters (including punctuations)
  forms a word e.g. "seven." in test case 1 represented by 6 => 1, "diddle,"
  and "fiddle!" in test case 2
- We return a empty hash input is an empty hash. Assume the same if the string
  contains just spaces?
- Hash keys are not in ascending order but also not matching the word length
  order of input text
- Note the keys are integers and not symbols
  
Data Structure
- input: String
- output: Hash
- intermediary: Likely the hash used in eventual output

Algorithm
1 - initialize empty hash using Hash.new with 0 as default value. This allows 
    us to increment the value directly based on key without detecting if the
    key already exists in hash
2 - split the string into an array of words using ' ' as delimiter
3 - If the array is empty, return empty hash
4 - Otherwise, for each word in array, count the length of word, the use the Hash#[]= operator
    to increment the counter
5 - Return the hash

=end

def word_sizes(text)
  length_counter = Hash.new(0)
  words = text.split # split by ' ' by default
  words.each do |word| # handles edge case of empty array too
    length_counter[word.size] += 1
  end
  
  length_counter
end


p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}


=begin

Solution

def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    counts[word.size] += 1
  end
  counts
end

Discussion

The main goal of this problem is to count the number of words of each size.
To do that, we first need to obtain a list of the words. Once we have a word,
computing its size is easy, but incrementing the count for words of that size
is slightly trickier. If we initialize counts as

counts = {}

we will get an exception the first time counts[word.size] += 1 is executed.
This is because that element doesn't exist, so counts[word.size] returns nil,
and nil cannot be added to 1. To fix this, we use the default value form of
initializing counts:

counts = Hash.new(0)

This forces any references to non-existing keys in counts to return 0.

Further Exploration

Take some time to read about Hash::new to learn about the different ways to
initialize a hash with default values.


Hash::new # class method
https://docs.ruby-lang.org/en/master/Hash.html#method-c-new

new(default_value = nil) → new_hash
new {|hash, key| ... } → new_hash

Returns a new empty Hash object.

The initial default value and initial default proc for the new hash depend
on which form above was used. See Default Values.

If neither an argument nor a block given, initializes both the default value
and the default proc to nil:

h = Hash.new
h.default # => nil
h.default_proc # => nil

If argument default_value given but no block given, initializes the default
value to the given default_value and the default proc to nil:

h = Hash.new(false)
h.default # => false
h.default_proc # => nil

If a block given but no argument, stores the block as the default proc and
sets the default value to nil:

h = Hash.new {|hash, key| "Default value for #{key}" }
h.default # => nil
h.default_proc.class # => Proc
h[:nosuch] # => "Default value for nosuch"

=end