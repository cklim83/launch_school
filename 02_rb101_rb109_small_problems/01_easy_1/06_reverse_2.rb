=begin

Reverse It (Part 2)

Write a method that takes one argument, a string containing one or more words,
and returns the given string with words that contain five or more characters
reversed. Each string will consist of only letters and spaces. Spaces should
be included only when more than one word is present.

Examples:

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS

=end

=begin
Problem
- Input: String containing one or more words
- Output: String where only words with 5 or more characters are reversed, 
          their position in the sentence remains unchanged.
          
Clarifications
- Noted the following:
  - input string will have at least 1 word (no empty string), 
  - no special characters only spaces and letters
  - Assume words are interspersed by single spaces in the return string, 
    no matter how many spaces is used in input string

Examples
- See above. 

Data Structures
- Input: String
- Output: String
- Intermediary: Array of Strings (words)

Algorithm
- Split input string into new array of substrings (words) using whitespace as delimiter
- For each substring in this new array, reverse it if string length is >= 5, else no change
- Join all elements in new array into a string using whitespace as delimiter

=end

def reverse_word(string)
  transformed = [] 
  string.chars.each do |char|
    transformed.unshift(char)           
  end
  
  transformed.join("")
end

def reverse_words(string)
  words = string.split
  transformed_words = words.map do |word|
                        if word.length >= 5
                          reverse_word(word) # own implementation of String#reverse
                        else
                          word
                        end
                      end
  
  transformed_words.join(' ')    
end

puts reverse_words('Professional') == 'lanoisseforP'
puts reverse_words('Walk around the block') == 'Walk dnuora the kcolb'
puts reverse_words('Launch School') == 'hcnuaL loohcS'


=begin

Solution

def reverse_words(string)
  words = []

  string.split.each do |word|
    word.reverse! if word.size >= 5
    words << word
  end

  words.join(' ')
end


Discussion

When given a string or an array, and asked to evaluate each character or element,
your first instinct should be to reach for an iterator. Our goal here is to iterate
over the given string and check each word for the number of characters it contains.
If it has five or more characters then we'll reverse the word.

At the top of our method, we create an empty array named words that will hold each
modified word of the result: these words will be reversed if long, or as-is if they
are short. We use #each to iterate over string, but first, we need to separate each
word in string using #split, which returns an array containing the separated words.
For each word, we count the number of characters it contains using #size. If it
contains five or more characters, we use the destructive method #reverse! to reverse
the word. We mutate word so that we can add it to words by invoking words << word.

After iterating over string and evaluating each word, words will contain all of the
words, with longer words reversed. Finally, we can invoke words.join(' ') to return
the desired string.

=end