# rubocop:disable all
=begin

Scrabble Score

Write a program that, given a word, computes the Scrabble score for that word.

Letter Values

You'll need the following tile scores:
Letter 	Value
A, E, I, O, U, L, N, R, S, T 	1
D, G 	2
B, C, M, P 	3
F, H, V, W, Y 	4
K 	5
J, X 	8
Q, Z 	10

How to Score

Sum the values of all the tiles used in each word. For instance, lets consider
the word CABBAGE which has the following letters and point values:

    3 points for C
    1 point for each A (there are two)
    3 points for B (there are two)
    2 points for G
    1 point for E

Thus, to compute the final total (14 points), we count:

3 + 2*1 + 2*3 + 2 + 1
=> 3 + 2 + 6 + 3
=> 5 + 9
=> 14
=end


=begin
Problem
- input: Given a word
- output: return a score representing the sum of scores of letters forming that
          word. The score of each letter is as follows:
          
  Letter 	                        Value
  A, E, I, O, U, L, N, R, S, T 	  1
  D, G 	                          2
  B, C, M, P 	                    3
  F, H, V, W, Y 	                4
  K 	                            5
  J, X 	                          8
  Q, Z 	                          10

- Question: The word consist of only letters?
- Question: The case of the letter doesn't matter?
- Question: Edge case: will we get an empty str? Return 0?
- Question: Would we get an hypenated word? Non-letters has 0 value?

Examples
- input: CABBAGE, Output: 14 (3 + 1 + 3 + 3 + 1 + 2 + 1)

Other Test cases
- Requirements:
  - We need a Scrabble class, with constructor accepting 1 argument
  - The argument can be empty string '', score = 0
  - The argument can be white spaces " \t\n", score = 0
  - The argument can even be nil, score = 0
  - The argument can be single or multiple letter words, in upper or lower case
  - We have a score method to return the score. return 0 if word is not a 
    letter.
- Assume non-letters is possible in string, will have value of 0.
- We have a class method score that works the same way.


Data Structure
- Map the string to array of characters, then map it to array of integers
  according to rules, then sum it up.
- A hash mapping letters to value
  
Algorithm
1. Create class constant value map 
2. #constructor
    If input is not nil, assign stripped and upcased input to @tiles
3. #score
    - Return nil if @tiles is empty or nil
    - Convert @tiles to array of characters, then map each character to value 
      in value map using fetch with default value of 0 and store in values. 
    - reduce values by summing them together
    - return sum
=end
# rubocop:enable all

class Scrabble
  LETTER_VALUE = {
    "A" => 1,
    "E" => 1,
    "I" => 1,
    "O" => 1,
    "U" => 1,
    "L" => 1,
    "N" => 1,
    "R" => 1,
    "S" => 1,
    "T" => 1,
    "D" => 2,
    "G" => 2,
    "B" => 3,
    "C" => 3,
    "M" => 3,
    "P" => 3,
    "F" => 4,
    "H" => 4,
    "V" => 4,
    "W" => 4,
    "Y" => 4,
    "K" => 5,
    "J" => 8,
    "X" => 8,
    "Q" => 10,
    "Z" => 10
  }

  def self.score(tiles)
    tiles = tiles.strip.upcase if tiles

    return 0 if tiles.nil? || tiles.empty?

    values = tiles.chars.map { |char| LETTER_VALUE.fetch(char, 0) }
    values.reduce(:+)
  end

  def initialize(tiles)
    @tiles = tiles
  end

  def score
    self.class.score(@tiles)
  end
end

# rubocop:disable all
=begin
PEDAC solution

Understanding Problem
  For our program, the details we need to keep in mind are as follows:

    Our input will be a word for which we need to calculate the Scrabble score.
    The numeric value for letters is already determined for us:
        A, E, I, O, U, L, N, R, S, T — 1 point
        D, G — 2 points
        B, C, M, P. — 3 points
        F, H, V, W, Y — 4 points
        K — 5 points
        J, X — 8 points
        Q, Z — 10 points
    Each letter, even if repeated, counts towards the total.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create a
  Scrabble class. The class should have 3 methods as follows:

    A constructor that accepts a Scrabble word as its argument.

    A score method that calculates the score of the Scrabble word defined by
    the constructor. score takes no arguments and returns the score for the
    word. From the test cases, we can see that:
        Invalid words should return a score of 0.
        Words are case-insensitive (abc and ABC represent the same word).

    A class or static method also named score. Class and static methods are not
    executed by instances of the main class, but by the class itself. This
    version of score takes a single argument that contains the desired Scrabble
    word and returns its score.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structures
  Our input is usually a string, but we also need to deal with invalid input.
  It may be helpful to also use an array to calculate the score, and an object
  to keep track of our scoring standard.


Hints/Questions
  We need two methods named score: one is an instance method, the other is a
  class or static method.

    We should deal with invalid letters in the score instance method.
    The score class/static method can take advantage of the constructor and
    the score instance method.


Algorithm
    constructor
        Accept a Scrabble word as an argument and save it for later use.
        Ignore bad input at this point.

    Method: score
        Return 0 if word is invalid.
        Iterate through each letter and increment score by value of each letter.
        Return the final score.

    Method: score (static or class method)
        Accept a Scrabble word as an argument.
        We can leverage the constructor and score method described above.
        Return the score.


Solution and Discussion
class Scrabble
  attr_reader :word

  POINTS = {
    'AEIOULNRST'=> 1,
    'DG' => 2,
    'BCMP' => 3,
    'FHVWY' => 4,
    'K' => 5,
    'JX' => 8,
    'QZ' => 10
}
  def initialize(word)
    @word = word ? word : ''
  end

  def score
    letters = word.upcase.gsub(/[^A-Z]/, '').chars

    total = 0
    letters.each do |letter|
      POINTS.each do |all_letters, point|
        total += point if all_letters.include?(letter)
      end
    end
    total
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end

In our constructor, we assign @word to the given argument as long as it's not
nil. Within score, we clean up the string to ensure we're only dealing with
letters. Then, we iterate over each letter, as well as each key-value pair in
our POINTS hash, and add the appropriate points to our total. Notice, this
allows for empty strings to work fine because they essentially skip the
iterations and retain the score of 0 from the initialization of total.

For our score class method, we borrow all of the functionality of its instance
method counterpart.
=end


=begin
CONCEPT
- We can instantiate an instance of a class in a class method, then
  can the instance method within (given solution) to avoid repeating code

- We can call a class method within an instance method using self.class 
  (my solution) to avoid repeating code  
=end