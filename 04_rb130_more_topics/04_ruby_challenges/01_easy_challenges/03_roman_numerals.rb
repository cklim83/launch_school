# rubocop:disable all
=begin

Roman Numerals

Write some code that converts modern decimal numbers into their Roman number
equivalents.

The Romans were a clever bunch. They conquered most of Europe and ruled it
for hundreds of years. They invented concrete and straight roads and even
bikinis. One thing they never discovered though was the number zero. This
made writing and dating extensive histories of their exploits slightly more
challenging, but the system of numbers they came up with is still in use
today. For example the BBC uses Roman numerals to date their programmes.

The Romans wrote numbers using letters - I, V, X, L, C, D, M. Notice that
these letters have lots of straight lines and are hence easy to hack into
stone tablets.

 1  => I
10  => X
 7  => VII

There is no need to be able to convert numbers larger than about 3000.
(The Romans themselves didn't tend to go any higher)

Wikipedia says: Modern Roman numerals ... are written by expressing each
digit separately starting with the left most digit and skipping any digit
with a value of zero.

To see this in practice, consider the example of 1990. In Roman numerals,
1990 is MCMXC:

1000=M
900=CM
90=XC

2008 is written as MMVIII:

2000=MM
8=VIII

See also: On Roman Numerals (http://www.novaroma.org/via_romana/numbers.html)
=end


=begin
Problem
- Given a number in base ten, convert it to it roman numeral string
- Rules: Convert each digit (starting from left) to roman numeral, skip any 
  zeros
- No need to convert numbers bigger than 3000

- Writing RomanNumerals
I - The easiest way to note down a number is to make that many marks - little 
    Is. Thus I means 1, II means 2, III means 3. However, four strokes seemed
    like too many....
    
V - So the Romans moved on to the symbol for 5 - V. Placing I in front of the V
    — or placing any smaller number in front of any larger number — indicates
    subtraction. So IV means 4. After V comes a series of additions - VI means
    6, VII means 7, VIII means 8.

X - X means 10. But wait — what about 9? Same deal. IX means to subtract I from
    X, leaving 9. Numbers in the teens, twenties and thirties follow the same
    form as the first set, only with Xs indicating the number of tens. So XXXI
    is 31, and XXIV is 24.
    
L - L means 50. Based on what you ve learned, I bet you can figure out what 40
    is. If you guessed XL, you re right = 10 subtracted from 50. And thus 60,
    70, and 80 are LX, LXX and LXXX.
    
C - C stands for centum, the Latin word for 100. A centurion led 100 men. We
    still use this in words like "century" and "cent." The subtraction rule
    means 90 is written as XC. Like the Xs and Ls, the Cs are tacked on to the
    beginning of numbers to indicate how many hundreds there are: CCCLXIX is 369.
    
D - D stands for 500. As you can probably guess by this time, CD means 400. So
    CDXLVIII is 448. (See why we switched systems?)

M - M is 1,000. You see a lot of Ms because Roman numerals are used a lot to
    indicate dates. For instance, this page was written in the year of Nova
    Roma s founding, 1998 CE (Common Era; Christians use AD for Anno Domini,
    "year of our Lord"). That year is written as MCMXCVIII. But wait! Nova Roma
    counts years from the founding of Rome, ab urbe condita. By that reckoning
    Nova Roma was founded in 2751 a.u.c. or MMDCCLI.
    
_
V - Larger numbers were indicated by putting a horizontal line over them, which
    meant to multiply the number by 1,000. Hence the V at left has a line over
    the top, which means 5,000. This usage is no longer current, because the
    largest numbers usually expressed in the Roman system are dates, as
    discussed above.

Examples
- Define RomanNumeral class
- Constructor accepts an integer between 1 to 3000 inclusive
- to_roman method to return the RomanNumeric string

Data Structure
- For constructor:
  - input: integer
  - output: RomanNumeral object with input integer saved to instance variable
- For to_roman
  - input: None
  - output: String representing the RomanNumeral
  
Algorithm
- For constructor
  - Set @number to input integer
- For to_roman
     Initialize a constant hash with Roman Numerals as keys and values its
     integer equivalent
     Keys to be covered are: 
     - 1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000
     - 4s and 9s need to be included because instead of representing 40 as XXXX,
       we want it to be XL
     
  1. set curr_number = @number, roman_string = ""
  2. Sort hash by value, in descending order
  3. Iterate sorted_hash_array, pass key, value into block:
      - times_value, remainder = curr_number / value
      - Append key * times_value to roman_string
      - curr_number = remainder
  4. Return roman_string 
=end
# rubocop:enable all

class RomanNumeral
  ROMAN_NUMERALS = {
    "I" => 1,
    "IV" => 4,
    "V" => 5,
    "IX" => 9,
    "X" => 10,
    "XL" => 40,
    "L" => 50,
    "XC" => 90,
    "C" => 100,
    "CD" => 400,
    "D" => 500,
    "CM" => 900,
    "M" => 1000
  }

  def initialize(number)
    @number = number
  end

  def to_roman
    remainder = @number
    roman_string = ""

    # sort to descending value to avoid #each depending on the ROMAN_NUMERAL
    # hash order returning smaller values first.
    symbol_array = ROMAN_NUMERALS.sort_by { |_, value| -value }
    symbol_array.each do |symbol, value|
      count, remainder = remainder.divmod(value)
      roman_string << symbol * count
    end

    roman_string
  end
end

# rubocop:disable all
=begin

1. Problem

  For our program, the details we need to keep in mind are as follows:

    I stands for 1
    V stands for 5
    X stands for 10
    L stands for 50
    C stands for 100
    D stands for 500
    M stands for 1,000
    We don't have to worry about numbers higher than 3,000.
    Modern Roman numerals are written by expressing each digit of the number
    separately, starting with the left most digit and skipping any digit with
    a value of zero


2. Examples

  From the test cases shown above, we can see that we need to create a
  RomanNumeral class. The class should have 2 methods as follows:

    A constructor that accepts a non-Roman integer number as an argument.
    From the test cases, it appears that the constructor does not raise
    any errors.

    A method that returns the Roman numeral representation of that number
    as a string. The name of this method will be either to_roman or
    toRoman depending on the conventions for your programming language of choice.

  We may also want to create some helper methods to assist us, but those are
  optional.
  

3. Data Structures

  Our input is an integer in our language of choice, and our output is a string.
  We may want to use some type of collection to help us create the desired
  output since it can make iteration easier. It might also be a good idea to
  have another collection hold some key conversions between numbers and Roman
  numerals.

  We may also need a separate collection that holds key conversions between
  numbers and Roman numerals. How would ascending or descending order impact
  its ease of use?


4. Hints and Questions

  We need one instance method named toRoman that returns the Roman number as a
  string based on the value of the number defined by the constructor.
  
  
5. Algorithm

    constructor
        Accept a number as an argument.
        Save it for later use.

    Roman Numerals Collection
        Create a collection that links important Roman numeral strings to their
        numeric counterparts. Ensure this is in descending order.

    Method: Convert to Roman Numerals (Ruby: to_roman; JavaScript: toRoman)
        Initialize a variable with an empty string to save the finished Roman
        conversion.
        Iterate over the Roman Numerals collection:
            If the numeric value of the current Roman numeral is less than the
            value of the input number, add the Roman numerals to the string as
            many times as its value can fit. For instance, if the current Roman
            numeral is C (which has a value of 100) and the input number is 367,
            then 3 C's are needed: CCC.
            
            Subtract the numeric value of the added Roman numerals from the
            current input value, and use the new input value in subsequent
            iterations. For instance, since we added CCC to the string above,
            we must subtract 300 from 367, leaving us with a new input number
            of 67.
        
        Return the result string.
       
        
6. Code

class RomanNumeral
  attr_accessor :number

  ROMAN_NUMERALS = {
    "M" => 1000,
    "CM" => 900,
    "D" => 500,
    "CD" => 400,
    "C" => 100,
    "XC" => 90,
    "L" => 50,
    "XL" => 40,
    "X" => 10,
    "IX" => 9,
    "V" => 5,
    "IV" => 4,
    "I" => 1
  }

  def initialize(number)
    @number = number
  end

  def to_roman
    roman_version = ''
    to_convert = number

    ROMAN_NUMERALS.each do |key, value|
      multiplier, remainder = to_convert.divmod(value)
      if multiplier > 0
        roman_version += (key * multiplier)
      end
      to_convert = remainder
    end
    roman_version
  end
end

In the ROMAN_NUMERALS constant, we created key value pairs that connect Roman
numerals with their number equivalents in descending order. This sets it up well
to be iterated through in the proper order.

In the constructor, we simply save the number argument for later use through an
instance variable.

In to_roman, we first create a string to save our Roman numeral version of the
number. We then initialize to_convert and assign it to the same number number
is pointing to. This allows us to use that number without altering number's
value.

We iterate through each of the key value pairs from the ROMAN_NUMERALS hash.
divmod returns an array of two numbers: the first, how many times number is
divisible by value and the second, the remainder of such division. If number is
less than the value, the remainder will be the same as number and multiplier
will be 0. But if the multiplier is anything greater than 0, we know that we
need that letter or pair of letters in our Roman numeral conversion, so we add
it to the string. And we need to add it to the string however many times it was
evenly divided. Then we reassign number to our remainder.

After iterating through ROMAN_NUMERALS, we return the completed roman_version.

There is a potential problem with this solution: we're assuming that #each
method will return the keys in the same order as shown in the declaration of
ROMAN_NUMERALS. While this is true in recent versions of Ruby, there are no
guarantees made. Furthermore, it's not good practice to rely on the ordering
produced by Hash#each (nor with any other method that returns the keys, values,
or key/value pairs from a hash).


As an extra challenge, try to fix this code so it doesn't depend on the
ordering returned by the #each. To make sure your code works correctly, reverse
the order of the entries in
ROMAN_NUMERALS.

ROMAN_NUMERALS = {
  "I" => 1
  "IV" => 4,
  "V" => 5,
  "IX" => 9,
  "X" => 10,
  "XL" => 40,
  "L" => 50,
  "XC" => 90,
  "C" => 100,
  "CD" => 400,
  "D" => 500,
  "CM" => 900,
  "M" => 1000,
}

=end


