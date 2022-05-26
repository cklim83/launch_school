# rubocop:disable all
=begin

Point Mutations

Write a program that can calculate the Hamming distance between two DNA
strands.

A mutation is simply a mistake that occurs during the creation or copying
of a nucleic acid, in particular DNA. Because nucleic acids are vital to
cellular functions, mutations tend to cause a ripple effect throughout
the cell. Although mutations are technically mistakes, a very rare
mutation may equip the cell with a beneficial attribute. In fact, the
macro effects of evolution are attributable by the accumulated result
of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point
mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands
taken from different genomes with a common ancestor, we get a measure of
the minimum number of point mutations that could have occurred on the
evolutionary path between the two strands.

This is called the Hamming distance.

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^

The Hamming distance between these two DNA strands is 7.

The Hamming distance is only defined for sequences of equal length. If
you have two sequences of unequal length, you should compute the Hamming
distance over the shorter length.
=end

=begin
Problem
- Compare two DNA strands that may or may not be equal in length
- Calculate the hamming distance, an integer representing the number of differences at respective positions based on common length

Examples (From test suite)
- DNA Class
- Constructor accept a string representing the DNA bases
- The class defines a hamming distance instance method that accepts a string representing DNA bases
- Strands can be empty string, return 0
- Strands can be equal length, return the difference count
- Strands can be different length, consider the smaller common length, return the difference count
- Bases are only one of 'A', 'G', 'C', 'T'

Data Structure
- DNA constructor accepts a single string argument. Can be stored in @bases
- Has a instance method hamming_distance that accepts 1 string argument and return an integer
- other helper methods, if required

Algorithm
1. Set @bases in DNA constructor to input string
2. Set difference_count = 0, common_length = shorter of two strings
3. Set index = 0
4. while index < common_length
     difference_count += 1 if @bases[index] != other_strand[index]
     index += 1
5. Return difference_count
=end
# rubocop:enable all

class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    difference_count = index = 0
    common_size = [@strand.size, other_strand.size].min

    while index < common_size
      difference_count += 1 if @strand[index] != other_strand[index]
      index += 1
    end

    difference_count
  end
end

# rubocop:disable all
=begin
Solution

1. Problem

  For our program, the details we need to keep in mind are as follows:

    We will be given two strands of DNA.
    We need to count the differences between them.
    If one strand is shorter than the other, we only need to check for 
    differences for the length of the shorter strand.


2. Examples

  From the test cases shown above, we can see that we need to create a DNA
  class. The class should have 2 methods as follows:

    A constructor that accepts a DNA strand string as argument. The constructor
    does not raise any errors.

    A method that accepts a second DNA strand string as an argument and returns
    the differences between the two strands — the Hamming distance.

 We may also want to create some helper methods to assist us, but those are
 optional.

 
3. Data Structures

  We're given the DNA strands as strings. Additionally, we may want to use a
  collection to help us iterate through each character of the DNA strand.


4. Hints or Questions
  
  Method for calculating Hamming distance:

    How can we know which DNA strand is shorter?
    How can we count the differences between them? What kind of iteration will help us do that?


5. Algorithm

    constructor
        Accept a DNA strand string as an argument.
        Save it for later use.

    Method: Compute Hamming Distance (Ruby: hamming_distance; 
                                      JavaScript: hammingDistance)
        Compare the lengths of both DNA strands to determine which is shorter.
        Set a counter to 0.
        Based on the shorter strand's length, iterate through both DNA strand
        strings, at the same index, and compare each character.
            If the characters are different, increase the counter.
            Continue to the next index position.
        Return the counter.

6. Code
class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(comparison)
    shorter = @strand.length < comparison.length ? @strand : comparison
    differences = 0

    shorter.length.times do |index|
      differences += 1 unless @strand[index] == comparison[index]
    end

    differences
  end
end

In the constructor, we simply save the first DNA strand string for later use.

In hamming_distance, we use a ternary operator to determine which of the two
strands — original strand or the comparison — is shorter. 
We then initialize a counter — differences — to 0. Next, we use the shorter's
length to determine the amount of iterations we need to perform. We then use
the parameter index to compare the proper locations in both DNA strands. If
the characters differ, we increase differences. We then return the amount of
differences at the end.
=end