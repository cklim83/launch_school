=begin

Series

Write a program that will take a string of digits and return all the possible
consecutive number series of a specified length in that string.

For example, the string "01234" has the following 3-digit series:

    012
    123
    234

Likewise, here are the 4-digit series:

    0123
    1234

Finally, if you ask for a 6-digit series from a 5-digit string, you should
throw an error.
=end

=begin
Problem
- input: a string of digits, n representing length of consecutive number series
- output: an array of array containing consecutive digits of length n

Examples
- Requirements
  - Series class, with constructor accepting a string of digits
  - A slice instance method accepting an integer input representing the length
    of consecutive digit substrings.
  - input digit string can be various length. Edge case: can input string be
    an empty string? Assume yes. But since n > 0, this should raise an error 
    Can n be <=0?, assume no since result would not be useful.
  - Leading zeros have to be preserved
  - The output should follow the order of the input string
  - Raise ArgumentError if length of input string < n.
  - Do we need to validate the input string? Assume yes. 

Data Structures
- string for digits_string
- integer n for size of subarrays
- nested array for output
- An array of individual digits for slicing. Cannot use Integer#digits since
  some input strings have leading zeros which will disappear since
  '00123'.to_i.digits == [3, 2, 1]

Algorithm
- Constructor
  - Create a Series class constructor that accept a string
  - assign number_string to @number_string if valid?(number_string)

- #slice(n)
  - raise ArgumentError if n > @number_string.length || n < 1
  - Set result = []
  - Convert @number_string into an array of characters and map each element
    into an integer. Assign result to digits_array
  - Iterate through the index of digits_array
    - slice digit_array at index of size n, append it to result
    - break if index + n + 1 > digit_array size (i.e. next iteration will be 
      out of index)
  - return result

- valid?(number_string)
   return true if all characters are numbers
=end


class Series
  attr_reader :number_string
  def initialize(number_string)
    @number_string = number_string if valid_string?(number_string)
  end
  
  def slices(n)
    raise ArgumentError if n > number_string.length || n < 1
    
    result = []
    digits_array = number_string.chars.map(&:to_i)
    digits_array.each_index do |index|
      result << digits_array[index, n]
      break if index + n + 1 > digits_array.size
    end
    
    result
  end
  
  private
  
  def valid_string?(number_string)
    number_string.chars.all? { |char| char =~ /[0-9]/ }
  end  
end


=begin
PEDAC Solution

Understand Problem
  For our program, the details we need to keep in mind are as follows:

    We'll be given two important values: a string of numerical digits &
    a number representing the desired length of the series.
    
    Each possible series we extract must be consecutive numbers from the
    original string. That means, from the string '01234', '213' is not a
    valid option, but '123' is.
    

Examples and Test Cases
  From the test cases shown above, we can see that we need to create a
  Series class. The class should have 2 methods as follows:

    a constructor that accepts a string of digits as an argument
    
    a slices method that takes a number as an argument. That number is the
    length of the possible series we must determine. We can see from the
    provided test cases that the return value of this method is an array of
    arrays. Each sub-array contains a series of numbers.

  Note that if the length is greater than the length of the number string, we
  need to throw an error.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structure
  We are using both strings and numbers. We also need to use a collection
  to return all possible number series. We noted above under the 'Test Cases'
  heading that our series method should return an array. Each element of that
  array is itself an array, containing the digits of each series.


Hints and Questions
    The slices method should throw an error if the length is invalid.
    How can we create substrings that are the proper length?


Algorithm
    constructor
        Save the string of digits passed as an argument

    Method: slices
        Accept a number as an argument — the length.
        
        Throw an error if the length is greater than the length of the number
        string
        
        Starting with the first digit in the number string, create substrings
        of length size.
        
        Save the digits of each substring (the series) into an array.
        
        Return an array of arrays that contains every series.


Ruby Solution and Discussion

class Series
  attr_accessor :str

  def initialize(str)
    @number_string = str
  end

  def slices(length)
    raise ArgumentError.new if length > number_string.size
    number_string.chars.map(&:to_i).each_cons(length).to_a
  end
end

In the constructor, we simply save the number string for later use in a
clearly-named instance variable.

Within slices, we raise an ArgumentError if the length is greater than the
size of the number string.

The next line of slices can look rather dense, so let's break it down with
an example of 1234 as our number string, and our length as 2. First, we use
chars to break the number string into an array of characters: 
['1', '2', '3', '4']. Next, we use map(&:to_i) to transform all of the digits
into integers: [1, 2, 3, 4]. Then, we use each_cons(length).to_a to return
sub-arrays of consecutive digits that are length in size: 
[[1, 2], [2, 3], [3, 4]].

=end


=begin
TO REVIEW
- When raising an exception, raise an new object using ErrorType.new
- Array#each_cons(length) results a enumerator of consecutive elements of size 
  length
=end
