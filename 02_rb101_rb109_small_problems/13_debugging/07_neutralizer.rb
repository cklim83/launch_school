=begin

Neutralizer

We wrote a neutralize method that removes negative words from
sentences. However, it fails to remove all of them. What exactly happens?

def neutralize(sentence)
  words = sentence.split(' ')
  words.each do |word|
    words.delete(word) if negative?(word)
  end

  words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.
=end

=begin
My answer:
We are mutating the caller while iterating through it. This cause the unexpected 
result. To fix this, we could create a clone and mutate the clone rather than the 
caller.
=end


def neutralize(sentence)
  words = sentence.split(' ')
  clean_words = words.clone
  words.each do |word|
    clean_words.delete(word) if negative?(word)
  end

  clean_words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.


=begin
Solution

def neutralize(sentence)
  words = sentence.split(' ')
  words.reject! { |word| negative?(word) }
  words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
#=> These cards are part of a board game.

Discussion

While iterating over an array, avoid mutating it from within the block.
Instead you can use the Array methods select or reject/reject!.

Further Exploration

Note that we use reject! here, which does mutate the array while iterating
over it. But the way reject! is implemented, it takes special care to avoid
the problem we had in our code. We could re-implement it in Ruby as follows:

def mutating_reject(array)
  i = 0
  loop do
    break if i == array.length

    if yield(array[i]) # if array[i] meets the condition checked by the block
      array.delete_at(i)
    else
      i += 1
    end
  end

  array
end

For now, just read if yield(array[i]) as "if array[i] meets the condition
checked by the block"; you will learn about using blocks in methods in course
RB130. The important point is that i is not increased when the condition is met
and the element is removed. This prevents the loop from skipping over elements
like what happened in our case.
=end


=begin
TO REVIEW
- Using #reject
=end