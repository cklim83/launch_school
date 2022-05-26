# rubocop:disable all
=begin

Diamond

The diamond exercise takes as its input a letter, and outputs it in a diamond
shape. Given a letter, it prints a diamond starting with 'A', with the supplied
letter at the widest point.

    The first row contains one 'A'.
    The last row contains one 'A'.
    All rows, except the first and last, have exactly two identical letters.
    The diamond is horizontally symmetric.
    The diamond is vertically symmetric.
    The diamond has a square shape (width equals height).
    The letters form a diamond shape.
    The top half has the letters in ascending order.
    The bottom half has the letters in descending order.
    The four corners (containing the spaces) are triangles.

Examples

Diamond for letter 'A':

A

Diamond for letter 'C':

  A
 B B
C   C
 B B
  A

Diamond for letter 'E':

    A
   B B
  C   C
 D     D
E       E
 D     D
  C   C
   B B
    A

=end

=begin
Problem
- input: Given a letter
- output: A string that satisfies the following conditons
          - First and last row starts with 'A'
          - All rows except first and last have 2 identical letters
          - Shape is symmetric vertically
          - Shape is symmetric horizontally
          - Shape is within a square frame (width == height)
          - Top half is in ascending alphabets
          - Bottom half is in descending alphabets
          - Alphabets forms shape of diamond, four corners of spaces form 
            triangle

Examples and Test Cases

Requirements
- A Diamond class with a make_diamond class method accepting a single char 
  string as input
- Valid input is a single char letter within 'A'..'Z' or 'a'..'z'. Multiple 
  letter is invalid
- If input is lower case, will convert to uppercase
- Each row have both leading and trailing spaces
- The string ends with a newline
- 'A' is special, only printed once on row. The other letters are printed twice.

input: 'A'  
A              width = height = 1, print 'A'
  
input: 'B'
 A             width = height = 3
B B            outside_spaces = [1, 0, 1]
 A             inside_spaces = [0, 1, 0]

input: 'C'
  A            width = height = 5
 B B           outside_spaces = [2, 1, 0, 1, 2]
C   C          inside_spaces = [0, 1, 3, 1, 0]
 B B
  A

Pattern:      width = height = 2 * (position offset of input from 'A') + 1 
              outside_spaces = [(width-1)/2..1] + [0] + [1..(width-1)/2]
              inside_spaces = [0] + [odd numbers from 1..(width-4)] + [width-2] 
                              + [odd numbers from (width-4) to 1] + [0]
              
              Top half = bottom half reverse

Data Structures
- input: Single letter string
- output: string
- Arrays to store multiples of outside and inside spaces for each row,
  Array to store diamond pattern

Algorithm

make_diamond(input)
1. raise argument error unless input is valid
2. assign input to upcased input
3. return "A\n" if input equals 'A'   

4. set pattern_holder = []
5. width = 2 * (position offset from 'A') + 1
6. mid_point = (width - 1) / 2
7. outside_spaces = [mid_point downto 1] 
8. inside_spaces = [0] + [odd numbers from 1..(width - 4)
9. build_shape(pattern_holder, outside_spaces, inside_spaces)
10. pattern_holder << "#{input}" + " " * (width-2) + "#{input}" +"\n"
11. build_shape(pattern_holder, outside_spaces.reverse, inside_spaces.reverse)
12. return elements in pattern holder joined with newline

offset_from_a(input)
- return code point of input - codepoint of 'A'

build_shape(holder, letters, outside_spaces, inside_spaces)
- iterate over letters with index
  - row_string = " " * outside_spaces[index] + letter + " " *inside_spaces[index]
  - row_string += letter if letter is not 'A'
  - row_string += " " * outside_spaces[index] + "\n"
  - append row_string to holder
=end

# rubocop:enable all

class Diamond
  def self.make_diamond(char)
    raise ArgumentError unless valid_char?(char)

    char = char.upcase
    return "A\n" if char == 'A'

    width = 2 * offset_from_a(char) + 1
    top_half_array = build_top_half(width, char)
    middle_row = char + " " * (width - 2) + char
    bottom_half_array = top_half_array.reverse
    diamond_array = top_half_array + [middle_row] + bottom_half_array

    diamond_array.join("\n") + "\n"
  end

  class << self
    private

    def valid_char?(char)
      !!(char =~ /^[a-z]$/i)
    end

    def offset_from_a(char)
      char.ord - 'A'.ord
    end

    def build_top_half(width, end_char)
      row_strings = []
      inside_spaces = [0] + (1..(width - 4)).select(&:odd?)

      ('A'...end_char).each_with_index do |char, row|
        row_str = char == 'A' ? 'A' : char + " " * inside_spaces[row] + char
        row_strings << row_str.center(width)
      end

      row_strings
    end
  end
end

# rubocop:disable all
=begin
PEDAC Solution

Understanding the Problem
  We need to create a diamond of letters based on the input letter we receive.
  The requirements given in the instructions broke down all of the details we
  need to keep in mind. Again, they are:

    The first row contains one 'A'.
    The last row contains one 'A'.
    All rows, except the first and last, have exactly two identical letters.
    The diamond is horizontally symmetric.
    The diamond is vertically symmetric.
    The diamond has a square shape (width equals height).
    The letters form a diamond shape.
    The top half has the letters in ascending order.
    The bottom half has the letters in descending order.
    The four corners (containing the spaces) are triangles.
    

Examples and Test Cases
  From the test cases shown above, we can see that we need to create a Diamond
  class. This class only needs one method:

    A method that accepts one argument, a letter. This method should return a
    diamond based on the input letter.
        This method is defined as a static or class method.

  A few additional details to note:

    The diamond always begins and ends with the letter A. The second row of B
    has one space between letters. All subsequent rows have an additional 2
    spaces between letters compared to the previous row.

    We need to preserve the width of the longest row in the shorter rows. That
    is, if "E" is the longest row and is 9 characters long, the A row needs to
    be 9 characters long also.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structures
  Our input and output for the method are both strings. We may also want to
  use arrays to build our diamond, because its built-in methods may prove
  helpful.
  

Hints and Questions
  The method to make a diamond should first determine what letters are needed
  in each row of the diamond. Once that is done, iterate over the letters
  creating one row at a time.
  
  
Algorithm
    Method to make a diamond (Ruby: make_diamond; JavaScript: makeDiamond)
        Create a range of letters: 'A' until the given letter and then back to
        'A' in reverse. Note that the given letter only appears once in this
        range.
        
        Calculate the width of the diamond. We will use a helper method.
        
        Iterate over the range of letters, and create a row for each current
        letter. We will use a helper method.
            Center the row with spaces
            Join all rows with a newline and append a final newline.

    Helper method: make a row
        If current letter is 'A', return 'A'.
        
        If current letter is 'B', return 'B B'.
        
        Create and return a string consisting of the current letter separated
        by the appropriate number of spaces. A helper method is useful here.

    Helper method: determine spaces between letters
        If the letter is 'A', return "" (an empty string).
        
        If the letter is 'B', return " " (a single space).
        
        Starting with letter C, the amount of spaces needed between letters is
        3. Every subsequent letter needs two more spaces: D needs 5, E needs 7,
        etc.
            Use a loop to figure out the amount of spaces needed based on this
            formula
            
            Return the correct amount of spaces as a string

    Helper method: determine width of diamond
        If the letter is 'A', return 1
        
        Otherwise, determine number of spaces between letters and add 2 for
        the letters at either end.

Additional helpers may be needed.


Ruby Solution and Discussions

class Diamond
  def self.make_diamond(letter)
    range = ('A'..letter).to_a + ('A'...letter).to_a.reverse
    diamond_width = max_width(letter)

    range.each_with_object([]) do |let, arr|
      arr << make_row(let).center(diamond_width)
    end.join("\n") + "\n"
  end

  private

  def self.make_row(letter)
    return "A" if letter == 'A'
    return "B B" if letter == 'B'

    letter + determine_spaces(letter) + letter
  end

  def self.determine_spaces(letter)
    all_letters = ['B']
    spaces = 1

    until all_letters.include?(letter)
      current_letter = all_letters.last
      all_letters << current_letter.next
      spaces += 2
    end

    ' ' * spaces
  end

  def self.max_width(letter)
    return 1 if letter == 'A'

    determine_spaces(letter).count(' ') + 2
  end
end

In make_diamond, we first create the range of letters we will be using: A up to
the max letter, then descending. Note that we don't repeat the max letter. We
then determine the width of our diamond by using the max_width method.

We then iterate over the range of letters, and use our helper method make_row
and the built-in String#center to create our rows appropriately. We then join
all rows with a new line and add a newline at the very end of the string.

In max_width, we use a guard clause for A. Otherwise, we count the amount of
spaces returned by determine_spaces which uses the max letter to calculate our
max length of a row. We add 2 to this number to account for the 2 letters on
all rows (except for an A row).

In make_row, we use guard clauses to return the rows for A and B. After that,
we simply return the letter repeated twice with the appropriate amount of
whitespace between them. We delegate the whitespace calculation to
determine_spaces.

In determine_spaces, we begin with the letter C and the amount of spaces it
needs: 3. We continue to add the next letter in the alphabet to this collection
of letters, and also incrementing the amount of spaces by 2, until we have
reached the letter we need. We then return the appropriate amount of spaces.
=end


=begin
CONCEPTS
- The helper methods in the given solution are public and not private. For
  private class methods, we need to wrap them as such
  
  class ClassName
    ...
    
    class << self
      private
      
      def self.my_private_class_method
        ...
      end
    end

  end
=end