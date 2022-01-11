=begin

Egyptian Fractions

A Rational Number is any number that can be represented as the result of the
division between two integers, e.g., 1/3, 3/2, 22/7, etc. The number to the
left is called the numerator, and the number to the right is called the
denominator.

A Unit Fraction is a rational number where the numerator is 1.

An Egyptian Fraction is the sum of a series of distinct unit fractions (no
two are the same), such as:

1   1    1    1
- + - + -- + --
2   3   13   15

Every positive rational number can be written as an Egyptian fraction. 
For example:

    1   1   1   1
2 = - + - + - + -
    1   2   3   6

Write two methods: one that takes a Rational number as an argument, and
returns an Array of the denominators that are part of an Egyptian Fraction
representation of the number, and another that takes an Array of numbers
in the same format, and calculates the resulting Rational number. You will
need to use the Rational class provided by Ruby.

Examples:

egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)

Every rational number can be expressed as an Egyptian Fraction. In fact, every
rational number can be expressed as an Egyptian Fraction in an infinite number
of different ways. Thus, the first group of examples may not show the same
values as your solution. They do, however, show the expected form of the
solution. The remaining examples merely demonstrate that the output of egyptian
can be reversed by unegyptian.

For more info on Egyptian Fractions, see this page.
=end

=begin
Problem (egyptian)
- input: a rational number
- output: an array of numbers representing the denominators of egyptian fraction
          representation of the rational number
          
Examples
- requirements
  - We have to use the Rational class to represent fractions
  - The denominators have to be unique
  - Sum of egyptian fraction to equal the rational number
  
Data Structure
- input: Rational
- output: array of positive unique integers

Algorithm
- Let current_denominator = 1, denominators = [], current_value = 0
- repeat until input_rational_number - current_value equals zero
  - if input_rational_number - (current_value + Rational(1, current_denominator)) >= 0,
    - denominators << current_denominator
    - current_value += Rational(1, current_denominator)
    end
    - increment current_denominator
  end
  
unegyptian
  - array.reduce { |sum, denom| sum += Rational(1, denom) }
=end

def unegyptian(denominators)
  denominators.reduce(0) { |sum, denom| sum += Rational(1, denom) }
end

def egyptian(fraction)
  current_denominator = 1
  denominators = []
  current_value = 0
  while fraction - current_value != 0
    if fraction - (current_value + Rational(1, current_denominator)) >= 0
      denominators << current_denominator
      current_value += Rational(1, current_denominator)
    end
    
    current_denominator += 1
  end
  
  denominators
end


p egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
p egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
p egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]


p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)


=begin
def egyptian(target_value)
  denominators = []
  unit_denominator = 1
  until target_value == 0
    unit_fraction = Rational(1, unit_denominator)
    if unit_fraction <= target_value
      target_value -= unit_fraction
      denominators << unit_denominator
    end

    unit_denominator += 1
  end

  denominators
end

def unegyptian(denominators)
  denominators.inject(Rational(0)) do |accum, denominator|
    accum + Rational(1, denominator)
  end
end

Discussion

We use the Rational class for this problem to avoid precision problems with
floating point representations. Had we tried this problem using floating
point numbers, we could easily get incorrect results, or even an infinite
loop. The Rational number class avoids this by using an exact representation
for rational numbers.

Our approach to this problem starts with the target value, numerator / denominator,
and a unit fraction of 1 / 1. If 1 / 1 can be subtracted from the target value
without producing a negative result, then we have one of the unit fractions we
need, and add the denominator to our results list. We also subtract the unit
fraction from our target value. Next, we do the same thing with 1 / 2, then
1 / 3, and so on, until our target value is reduced to exactly 0. At this point,
we have one of the possible Egyptian Fraction representations of our original number.

Reversing this process is straightforward: we simply use Enumerable#inject to
add up all of the unit fractions.
=end

=begin
TO REVIEW
- need a starting value as argument to reduce to handle edge case
  
  denominators.reduce { |sum, denom| sum += Rational(1, denom) } returns nil if denominator == []
  denominators.reduce(0) { |sum, denom| sum += Rational(1, denom) } returns 0 if denominator == []
=end