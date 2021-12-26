=begin

Madlibs

Mad libs are a simple game where you create a story template with blanks
for words. You, or another player, then construct a list of words and place
them into the story, creating an often silly or funny story as a result.

Create a simple mad-lib program that prompts for a noun, a verb, an adverb,
and an adjective and injects those into a story that you create.

Example

Enter a noun: dog
Enter a verb: walk
Enter an adjective: blue
Enter an adverb: quickly

Do you walk your blue dog quickly? That's hilarious!
=end

=begin
Solution

print 'Enter a noun: '
noun = gets.chomp

print 'Enter a verb: '
verb = gets.chomp

print 'Enter an adjective: '
adjective = gets.chomp

print 'Enter an adverb: '
adverb = gets.chomp

sentence_1 = "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"
sentence_2 = "The #{adjective} #{noun} #{verb}s #{adverb} over the lazy dog."
sentence_3 = "The #{noun} #{adverb} #{verb}s up #{adjective} Joe's turtle."

puts [sentence_1, sentence_2, sentence_3].sample

Discussion

Using string interpolation here instead of concatenation makes it more readable and
is generally considered more rubyish (especially given that it is a sentence).

The different madlib sentences are written within our Ruby file. Another option here,
one that is a bit more complicated, would be to read in a text file. Then, we could
use String#format to interpolate our noun, verb, adjective, and adverb into this file
=end
