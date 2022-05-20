=begin

Octal

Implement octal to decimal conversion. Given an octal input string, your
program should produce a decimal output. Treat invalid input as octal 0.

Note: Implement the conversion yourself. Don't use any built-in or library
methods that perform the necessary conversions for you. In this exercise, the
code necessary to perform the conversion is what we're looking for,

About Octal (Base-8)

Decimal is a base-10 system. A number 233 in base 10 notation can be understood
as a linear combination of powers of 10:

    The rightmost digit gets multiplied by 100 = 1
    The next digit gets multiplied by 101 = 10
    The digit after that gets multiplied by 102 = 100
    The digit after that gets multiplied by 103 = 1000
    ...
    The n*th* digit gets multiplied by 10n-1.
    All of these values are then summed.

Thus:

  233 # decimal
= 2*10^2 + 3*10^1 + 3*10^0
= 2*100  + 3*10   + 3*1

Octal numbers are similar, but they use a base-8 system. A number 233 in base 8
can be understood as a linear combination of powers of 18:

    The rightmost digit gets multiplied by 80 = 1
    The next digit gets multiplied by 81 = 8
    The digit after that gets multiplied by 82 = 64
    The digit after that gets multiplied by 83 = 512
    ...
    The n*th* digit gets multiplied by 8n-1.
    All of these values are then summed.

Thus:

  233 # octal
= 2*8^2 + 3*8^1 + 3*8^0
= 2*64  + 3*8   + 3*1
= 128   + 24    + 3
= 155
=end

=begin
Problem
- input: Octal string
- ouput: Decimal number
- Conversion rules
  Starting from the right most digit, 
    The rightmost digit gets multiplied by 8**0 = 1
    The next digit gets multiplied by 8**1 = 8
    The digit after that gets multiplied by 8**2 = 64
    The digit after that gets multiplied by 8**3 = 512
    ...
    The n*th* digit gets multiplied by 8**(n-1).
    All of these values are then summed.
- Invalid input is treated as octal 0, i.e. return 0

Examples
- Can string be negative?
- Can there be decimal points?
- What sort of invalid input should we expect? Having digits greater that
  octal system i.e. >= 8
  
Test cases
- We need a Octal class, with constructor that accept 1 string input
- We need a to_decimal method that converts the octal number to decimal
- We need to be able to handle the following inputs:
  - invalid strings with characters that are not '0'..'7'
- Assume no decimal points or negative values, which will need additional
  parsing
  
Data Structures
- input: string
- output: integer
- String for reversal so that we can operate from the least significant digit
  first
- An Array to hold the digits and use the index for conversion

Algorithm
- constructor
  - accept a string argument

- to_decimal
  - return 0 if valid? is false
  - reverse string, convert to array of characters
  - map array of characters to integer
  - set value = 0
  - iterate array of integer with index,
    - accumulate integer * 8**index to value
  - return value
  
- valid?
  - all characters between? '0'..'7'
=end


class Octal
  OCTAL_BASE = 8
  
  def initialize(value_string)
    @value = value_string
  end
  
  def to_decimal
    return 0 unless valid?
    
    value = 0
    reverse_digits.each_with_index do |digit, index|
      value += digit * (OCTAL_BASE ** index)
    end  
    
    value
  end
  
  private 
  
  def reverse_digits
    @value.reverse.chars.map(&:to_i)  # use @value.to_i.digits
  end
  
  def valid?
    @value.chars.all? { |char| char.between?('0', '7') }
  end
end


=begin
PEDAC Solution

Understanding Problem
  For our program, the details we need to keep in mind are as follows:

    The way to convert octal numbers to decimal numbers is to use base-8 in
    multiplication. 
    
    Going from right-to-left, we multiply each digit of the
    number by 8 raised to a certain power. For the first digit (from the right),
    the power is 0. For the second digit, the power is 1. This continues until
    we multiply each digit from the number.
    
    Valid octal numbers only include digits 0 through 7.
    

Examples and Test Cases
  From the test cases shown above, we can see that we need to create an Octal
  class. The class should have 2 methods as follows:

    a constructor that accepts a string as an argument that represents an octal
    number.
    
    a method that converts the argument into decimal and returns it as a number.
        
    We should return 0 if the argument has invalid characters such as
    letters or the digits 8 or 9.

  We may also want to create some helper methods to assist us, but those are
  optional.

  
Data Structures
  From the test cases, we can see that we're dealing with numbers and strings.
  We may want to use a collection (such as an array) for helpful built-in
  methods.
  
  
Hints and Questions
    The method that performs the conversion to decimal is also responsible for
    validating the input.
    
    The method should iterate through the number's digits from right-to-left
    and compute each digit as a power of base 8.


Algorithm
    constructor
        Accepts a string as an argument that represents an octal number.

    Method: convert to decimal (Ruby: to_decimal; JavaScript: toDecimal)
        If any character of the string being converted is not 0, 1, 2, 3, 4, 
        5, 6, or 7, return 0.
        
        Set a starting sum to 0.
        
        Reverse the digits.
        
        Iterate over digits one-by-one.
            For the first digit, multiply it by 8**0, then add it to sum.
            For the second digit, multiply it by 8**1, then add it to sum.
            Keep multiplying and adding to sum until all digits are processed.
        
        Return the sum.


Solution and Discussion

class Octal
  attr_reader :number

  def initialize(str)
    @number = str
  end

  def to_decimal
    return 0 unless valid_octal?(number)

    arr_digits = number.to_i.digits

    new_number = 0
    arr_digits.each_with_index do |num, exponent|
      new_number += (num * (8 ** exponent))
    end

    new_number
  end

  private

  def valid_octal?(num)
    num.chars.all? {|n| n =~ /[0-7]/}
  end
end


Our constructor is quite simple: it just accepts an argument and assigns it to
an instance variable so the value is readily available throughout the rest of
the code.

In to_decimal, we use a guard clause to ensure we have valid input. We used a
helper method valid_octal? that iterates through each of the characters in the
input string to make sure they're all numbers between 0 and 7. If they're not,
we default to returning 0; if they are all valid, we continue.

We convert the validated string of numbers into an array of numbers so that we
can iterate over them; digits reverses the digits of the number as it breaks it
into an array.

We use the each_with_index method so that we can use the index parameter as the
exponent, since they both increase at the same rate. We iterate over each digit,
multiplying it by the appropriate exponent, then adding it to the sum which is
also the new_number. We then return the completed new_number at the end.
=end


=begin
TO REVIEW
- Using .to_i.digits to convert a string to digits and first element
  is least significant digit.
  
  '123'.to_i.digits == [3, 2, 1]
  
- using str =~ regex pattern is equivalent to str.index(regex) which return the
  lowest index that matches the regex pattern or nil if none found.
  
- Noted good choice of names, valid_octal?, exponent, sum, arr_digits
=end
