=begin

Longest Sentence

Write a program that reads the content of a text file and then prints the
longest sentence in the file based on number of words. Sentences may end
with periods (.), exclamation points (!), or question marks (?). Any
sequence of characters that are not spaces or sentence-ending characters
should be treated as a word. You should also print the number of words in
the longest sentence.

Example text:

Four score and seven years ago our fathers brought forth
on this continent a new nation, conceived in liberty, and
dedicated to the proposition that all men are created
equal.

Now we are engaged in a great civil war, testing whether
that nation, or any nation so conceived and so dedicated,
can long endure. We are met on a great battlefield of that
war. We have come to dedicate a portion of that field, as
a final resting place for those who here gave their lives
that that nation might live. It is altogether fitting and
proper that we should do this.

But, in a larger sense, we can not dedicate, we can not
consecrate, we can not hallow this ground. The brave
men, living and dead, who struggled here, have
consecrated it, far above our poor power to add or
detract. The world will little note, nor long remember
what we say here, but it can never forget what they
did here. It is for us the living, rather, to be dedicated
here to the unfinished work which they who fought
here have thus far so nobly advanced. It is rather for
us to be here dedicated to the great task remaining
before us -- that from these honored dead we take
increased devotion to that cause for which they gave
the last full measure of devotion -- that we here highly
resolve that these dead shall not have died in vain
-- that this nation, under God, shall have a new birth
of freedom -- and that government of the people, by
the people, for the people, shall not perish from the
earth.

The longest sentence in the above text is the last sentence; it is 86 words
long. (Note that each -- counts as a word.)

Another Example

Download the book at http://www.gutenberg.org/cache/epub/84/pg84.txt, and run
your program on this file.

The longest sentence in this book is 157 words long.
=end

=begin
Problem
- input: a text file
- output: Integer showing the number of words in the longest sentence

Example
- Requirements
  - sentences are terminated by period(.), exclaimation mark (!)
    or question mark (?)
  - Any sequence of characters that are not spaces (e.g. --) or 
    sentence-ending characters should be treated as a word. 
  - To print the number of words in the longest sentence.

Data Structure
- input: string representing filename
- output: printing number of words in longest sentence

Algorithm
1. Load the text file in memory
2. Set longest_sentence = 0
3. Split the text in sentences using ('.!?') as delimiters
4. Iterate through each sentence
    split sentence into word using space as delimiter
    if size of resulting array > longest_sentence, set longest_sentence = size of array
   end
5. print longest_sentence
=end

#https://stackoverflow.com/questions/1877190/how-do-i-download-a-file-over-http-using-ruby

require 'open-uri'

content = open('http://www.gutenberg.org/cache/epub/84/pg84.txt').read
longest_sentence_size = 0
longest_sentence = nil
sentences = content.split(/[.?!]/)

sentences.each do |sentence|
    words = sentence.strip.split
    if words.size > longest_sentence_size
        longest_sentence_size = words.size
        longest_sentence = sentence
    end
end

p longest_sentence_size
puts longest_sentence


=begin
Solution

text = File.read('sample_text.txt')
sentences = text.split(/\.|\?|!/)
largest_sentence = sentences.max_by { |sentence| sentence.split.size }
largest_sentence = largest_sentence.strip
number_of_words = largest_sentence.split.size

puts "#{largest_sentence}"
puts "Containing #{number_of_words} words"

Discussion

This problem can be a bit tricky. Let's break this down step by step. First,
we read in the entire file. When the file gets read in, it is in the form of
one big string containing all the file's text.

Next, we use the method String#split. The punctuation marks .,!, and ? mark
the end of one sentence and the beginning of another. Because of that fact,
we can use these punctuation marks as places to split our string of text into 
sentences.

On this third line, we take our array of sentences and use the Enumerable#max_by
method to find the longest one.

We now have the largest sentence. To get the number of words in that sentence,
we use the same operations as we did in max_by. In this case we call those
methods on largest_sentence instead.

Further Exploration

You may have noticed that our solution fails to print the period at the end of
the sentence. Can you write a solution that keeps the period printed at the end
of each sentence?

What about finding the longest paragraph or longest word? How would we go about
solving that problem?
=end

=begin
TO REVIEW
- using File.read and open(url).read
- using split with multiple delimiters #split(/[.?!]/) or text.split(/\.|\?|!/)
- Enumerable#max_by
- String#strip
=end