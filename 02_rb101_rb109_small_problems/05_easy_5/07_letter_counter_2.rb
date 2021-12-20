=begin

Letter Counter (Part 2)

Modify the word_sizes method from the previous exercise to exclude non-letters
when determining word size. For instance, the length of "it's" is 3, not 4.

Examples

word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
word_sizes('') == {}

=end

=begin

Problem
- input: String of 1 or more words separated by space
- output: Hash with word_length as keys and occurrences as values

Example
- See above
- Only alphabets are to be considered when determining word length
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
4 - Otherwise, for each word in array, count the number of alphabets using
    String#count in a word, the use the Hash#[]= operator to increment the
    counter
5 - Return the hash

=end

def word_sizes(text)
  counts = Hash.new(0)
  words = text.split
  words.each do |word|
    length = word.count("a-zA-Z") # or word.downcase.count("a-z")
    counts[length] += 1
  end
  
  counts
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
p word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
p word_sizes('') == {}


=begin

Solution

def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    clean_word = word.delete('^A-Za-z')
    counts[clean_word.size] += 1
  end
  counts
end

Discussion

The only change we need to make to this method is to make sure that it does not
count non-letter characters in determining word sizes. This is easy to do: we
simply delete all non-letters from each word before we compute the size.

Further Exploration

If you haven't encountered String#delete before, take a few minutes to read up
on it, and its companion String#count (you need to read about #count to get all
of the information you need to understand #delete).

TO REVIEW
- String#count
- String#delete
- The regex used to provide the pattern to these methods


https://docs.ruby-lang.org/en/master/String.html#method-i-count

count([other_str]+) → integer

Each other_str parameter defines a set of characters to count. The intersection
of these sets defines the characters to count in str. Any other_str that starts
with a caret ^ is negated. The sequence c1-c2 means all characters between c1
and c2. The backslash character \ can be used to escape ^ or - and is otherwise
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


https://docs.ruby-lang.org/en/master/String.html#method-i-delete
delete([other_str]+) → new_str

Returns a copy of str with all characters in the intersection of its arguments
deleted. Uses the same rules for building the set of characters as String#count.

"hello".delete "l","lo"        #=> "heo"
"hello".delete "lo"            #=> "he"
"hello".delete "aeiou", "^e"   #=> "hell"
"hello".delete "ej-m"          #=> "ho"

=end