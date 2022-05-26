# rubocop:disable all
=begin

Anagrams

Write a program that takes a word and a list of possible anagrams and selects
the correct sublist that contains the anagrams of the word.

For example, given the word "listen" and a list of candidates like "enlists",
"google", "inlets", and "banana", the program should return a list containing
"inlets". Please read the test suite for the exact rules of anagrams.
=end


=begin
Problem
- inputs: a word string, and a list of word strings
- output: a list containing subsets of words that are anagrams to the input
          word
          
- What is anagram: An anagram is a word or phrase formed by rearranging the
letters of a different word or phrase, typically using all the original letters
exactly once.
- Question: Do we have to consider phrases? No assume just single word.
- Question: Does the word only consist of letters? Assume so.
- Question: Does the case matter? Assume no.
- Question: What happens if the list contains no anagram? Return an empty 
            array?
- Question: What happens when input is empty string? Return empty array? Yes
- Question: Is same valued string to input considered an anagram? No
- Question: Can output list have duplicated strings? Yes.


Examples
input: "listen", ["enlists", "google", "inlets", "banana"]
output: ["inlets"]

# Requirements from test file
- Class must be called Anagram, with constructor accepting a string
  representing the word of which anagrams are to be generated
- Class has a match instance method that accepts list of words and
  returns a list containing words that are anagrams to seed word.
- The order of the anagram list follows the input list
- words that are identical to seed word are not considered anagrams

What is an anagram?
- strings that are subsets to seed word are not anagrams, each letter of seed
  word must be used at least once.
- Words with more letters that the seed words are not anagrams
- Anagrams are case insensitive.
- Words with same total checksum but different letters are not anagrams
- Anagrams are case insensitive. Assume we do not change the cases of the words
  of the input list.

Data Structure
- Need to compare seed word with each word in the list. Iteration and 
  comparison and selection of anagrams needed. Use an array
- Comparing seed words with each word in list provide in #match would
  require string comparison
  
Algorithm
1. Initialize an Anagram object by providing a seed word to the constructor
2. Store the seedword in an instance_variable
3. Define a match method that accepts an array of words, and return a new array
   containing subset of words that are anagrams of the seed word
4. Define anagram?(test_word) that returns true is test_word is 
   an anagram of seed_word
5. Iterate through each element of the input array to #match, select those
   elements that returns where anagram?(element) returns true. 
6. Return these selections

anagram?(test_word)
1. return false if seed_word.downcase == test_word.downcase
2. Convert word to array of chars and sort them.
3. Compare equality of array of seed_word with array of test_words
=end
# rubocop:enable all

class Anagram
  def initialize(seed_word)
    @seed_word = seed_word
  end

  def match(words)
    words.select { |word| anagram?(word) }
  end

  private

  def anagram?(word)
    seed_word = @seed_word.downcase
    word = word.downcase

    return false if seed_word == word

    seed_word.chars.sort == word.chars.sort
  end
end

# rubocop:disable all
=begin
PEDAC Solution

Problem
  Some items from the instructions we want to keep in mind:

    Our input is a word and a list of words. The first input is the pattern
    string, and the second input is an array of strings that may be anagrams
    of the pattern string.
    
    From the instructions we can see that words are anagrams of each other 
    when they have the same number of letters and the same exact letters as
    each other. Notice that enlists isn't an anagram of listen since it has
    an extra 's'.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create an
  Anagram class. The class should have 2 methods as follows:

    a constructor that takes the pattern word as an argument
    a match method that takes a list of words as an argument (to test against
    the pattern we initialized in the constructor)

  We may also want to create some helper methods to assist us, but those are
  optional.

  The test cases confirm what the instructions suggested: anagrams must (a) be
  the same length, (b) have the same exact letters, abd (c) have the exact same
  number of the exact same letters. Letters cannot be reused.

  Additionally, a word is not an anagram of itself (e.g. corn is not an anagram
  of corn). Anagrams are not case sensitive -- Orchestra and Carthorse are
  anagrams of each other.

  Whether 0 anagrams, 1 anagram, or 5 anagrams are found, we need to return the
  output as an array — either of strings (when at least 1 anagram is found) or
  an empty array (in the case of 0 anagrams).


Data Structures
  From the test cases, we can see that we're dealing with numbers and strings.
  We may want to use a collection (such as an array) for helpful built-in
  methods.
  

Hints and Questions
  We can iterate over the list of possible anagrams and save those that are
  indeed anagrams.
  Anagrams must:

    be the same length
    have the same exact letters
    have the exact same number of the exact same letters. Letters cannot be
    reused.

  One way to check for anagrams is to sort both the characters in the pattern
  and the possible anagram in the same way and check whether they are equal
  to each other:

  pattern:  enlists       sorted: eilnsst
  word:     listens       sorted: eilnsst

  Since both "enlists" and "listens" have the exact same list of characters
  when sorted, the two words are anagrams of each other.
  

Algorithm

    constructor
        save the argument in lowercase

    Method: match
        Initialize an empty list for the anagrams
        Iterate over each word in the argument list
            Convert word to lowercase
            Is word an anagram of the word saved in the constructor?
                Yes. Add this word to list of anagrams.
        Return the list of anagrams.

    Helper method to detect anagrams
        Takes two arguments: the original word and the current word
        Are the two words the same?
            Yes. Return false.
        Extract and sort all letters of the original word.
        Extract and sort all letters of the current word.
        Are the two sorted lists of letters the same?
            Yes. Return true (the words are anagrams)
            No. Return false (the words are not anagrams)


Solution and Discussion

class Anagram
  attr_reader :word

  def initialize(word)
    @word = word.downcase
  end

  def match(word_array)
    word_array.select do |ana|
      ana.downcase != word && anagram?(ana, word)
    end
  end

  private

  def sorted_letters(str)
    str.downcase.chars.sort.join
  end

  def anagram?(word1, word2)
    sorted_letters(word1) == sorted_letters(word2)
  end
end

In the constructor, we went ahead and prepared the pattern to be used in
the match method. We saved it in lowercase in @word.

In the match method, we used select, which enables us to return an empty array
automatically if nothing meets our conditions, and a populated array if we find
anagrams.

Next, in order to select the appropriate words, we use a helper method
-- anagram?. This method method uses the sortedChars helper method to split
each word into an array of sorted characters that we can easily compare.

We needed to make sure the words matched, but not too much: we also ensured
that only words that weren't the exact pattern word were ignored in our
selection of anagrams.
=end




