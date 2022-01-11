=begin

Reverse Sentence

The reverse_sentence method should return a new string with the words of its
argument in reverse order, without using any of Ruby's built-in reverse
methods. However, the code below raises an error. Change it so that it
behaves as expected.

def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    reversed_words = words[i] + reversed_words
    i += 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'
=end


=begin
My answer
The cause of error is due to this line 
`reversed_words = words[i] + reversed_words`. This is because words[i] returns a string
which cannot be concatenated with the array referenced by reversed_words resulting in a 
TypeError: implicit conversion of Array to String. To solve this, we could do a array
slice words[i, 1] to return a single element array at that index to perform an array 
concatenation.
=end


def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    reversed_words = words[i, 1] + reversed_words
    i += 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'


=begin
Solution

def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    reversed_words = [words[i]] + reversed_words
    i += 1
  end

  reversed_words.join(' ')
end

Discussion

Both String and Array have a + method (String#+ and Array#+). The former
concatenates two strings, the latter concatenates two arrays. On line 7
we mix these two types: words[i] is a string and reversed_words is an array.
Recall that words[i] + reversed_words is syntactic sugar for 
words[i].+(reversed_words); we invoked String#+ with an array as argument,
causing a TypeError to be raised.

In order to resolve this type mismatch, we can simply turn words[i] into a
one-element array, as shown in the solution. Alternatively, we could also
use the Array#unshift method to prepend the String object onto the front of
our array:

def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    reversed_words.unshift(words[i])
    i += 1
  end

  reversed_words.join(' ')
end
=end