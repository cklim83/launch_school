=begin

Letter Swap

Given a string of words separated by spaces, write a method that takes this
string of words and returns a string in which the first and last letters of
every word are swapped.

You may assume that every word contains at least one letter, and that the
string will always contain at least one word. You may also assume that each
string contains nothing but words and spaces

Examples:

swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
swap('Abcde') == 'ebcdA'
swap('a') == 'a'

=end

=begin

Problem
- input: string of words separated by space
- out: each word has first and last letter swapped

Examples
- See above
- preserve the capitalization of swapped letters
- string contain only words and spaces
- each word has at least 1 letter (edge case)
- no empty strings edge case

Data Structure
- input: string
- output: string
- intermediary: array of words

Algorithm
1 split the string in array of words using space as delimiter
2 For each word, transform the word with first and last letter switched and return in new array
3 Join the words in array to form return string

=end

def switch_letters(word)
  return "" if word.size == 0 # edge case
  
  last_letter = word[-1]
  word[-1] = word[0]
  word[0] = last_letter
  word
end

def swap(sentence)
  words = sentence.split
  words.map! do |word|
    switch_letters(word)
  end
  words.join(' ')
end

p switch_letters("Hello")
p switch_letters("i")
p switch_letters("")

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'


=begin

Solution

Using substrings

def swap_first_last_characters(word)
  word[0], word[-1] = word[-1], word[0]
  word
end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word)
  end
  result.join(' ')
end

Discussion

Our solution takes a straightforward approach; it simply chops the string
into words, then iterates through all of the words using map, and produces
an array of modified words. We then apply join to that array to produce our
return value.

The tricky part here is actually swapping the first and last characters of
each word. Because of the mild trickiness, we use a separate method. It uses
this common idiom:

a, b = b, a

to exchange the values of a and b. In our method, a is the first letter of
the word, and b is the last letter of the word. When Ruby sees something like
this, it effectively creates a temporary array with the values from the right
side ([b, a]), and then assigns each element from that array into the
corresponding named variable:

a = b   # b is value from position 0 of temporary array (original value of b)
b = a   # a is value from position 1 of temporary array (original value of a)

Looked at another way, this is equivalent to:

temporary = [b, a]
a = temporary[0]
b = temporary[1]

This multiple-assignment syntax is powerful and complex, and it sometimes
surprises people who haven't seen it before. Nevertheless, you should at least
learn and use this idiomatic form of the syntax, but beware of using the more
complex forms allowed by Ruby.


Further Exploration

How come our solution passes word into the swap_first_last_characters method
invocation instead of just passing the characters that needed to be swapped?
Suppose we had this implementation:

def swap_first_last_characters(a, b)
  a, b = b, a
end

and called the method like this:

swap_first_last_characters(word[0], word[-1])

Would this method work? Why or why not?

=end

def swap_first_last_characters(a, b)
  puts "In Swap function before swap"
  puts "a:#{a.object_id}, b: #{b.object_id}"
  a, b = b, a
  # puts "In swap function after Swap"
  # puts "a:#{a.object_id}, b: #{b.object_id}"
  #a, b
end

def string_swap_first_last_characters
  p word = "Hello"
  puts "String - Before invocating swap function"
  puts "word[0]:#{word[0]} (#{word[0].object_id}), word[-1]: #{word[-1]} (#{word[-1].object_id})"
  p swap_first_last_characters(word[0], word[-1])
  puts "String - Return from swap function"
  puts "word[0]:#{word[0]} (#{word[0].object_id}), word[-1]: #{word[-1]} (#{word[-1].object_id})"
  p word
end

def array_swap_first_last_characters
  p word = ["1", "2", "3"]
  puts "Array - Before invocating swap function"
  puts "word[0]:#{word[0]} (#{word[0].object_id}), word[-1]: #{word[-1]} (#{word[-1].object_id})"
  p swap_first_last_characters(word[0], word[-1])
  puts "Array - Return from swap function"
  puts "word[0]:#{word[0]} (#{word[0].object_id}), word[-1]: #{word[-1]} (#{word[-1].object_id})"
  p word
end

string_swap_first_last_characters
array_swap_first_last_characters

a ="hello"
3.times do
  puts a[0].object_id
end

=begin
**TO REVIEW**:
- multiple assignment: b, a = a, b
- pass by value vs pass by reference *** Dun understand the further explore example

"In the second example: I would not call these "copies", because there are no 
preexisting string objects to copy from. I would describe it as follows: Two
new string objects, word[0] and word[-1], are created, and passed to your
method (and exactly as you say, the method has no access to the string word,
so it cannot change anything about it).

To expand on why I am emphasizing the point about the "copies": This relates
to the earlier point (from my previous reply) that a string like "ben" is not
composed of smaller string objects "b", "e" and "n". In other words, there is
really only one object around here, i.e., "ben". This is why we cannot "take
the "b" object and "copy" it" – there is no pre-existing "b" object. But what
we can do is create a string object "b" using "ben"[0]. So what "ben"[0]
actually does is give you a brand-new object – even though just by looking
at the expression, that's not what you might think.

I think this point is worth reflecting in terminology, especially because the
situation is different with arrays, despite the analogous notation (i.e.,
something like array[0])." 

Full explanation in forum post below
https://launchschool.com/posts/34294362

https://docs.ruby-lang.org/en/master/String.html#method-i-5B-5D
https://docs.ruby-lang.org/en/master/Array.html#method-i-5B-5D
=end
