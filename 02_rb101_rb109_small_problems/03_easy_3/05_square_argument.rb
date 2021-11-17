=begin

Squaring an Argument

Using the multiply method from the "Multiplying Two Numbers" problem,
write a method that computes the square of its argument (the square is
the result of multiplying a number by itself).

Example:

square(5) == 25
square(-8) == 64

=end

def multiply(n1, n2)
  n1 * n2
end

def square(n)
  multiply(n, n)
end

p square(5) == 25
p square(-8) == 64


# Generalized square to power n. n can be any integer
def power(base, exponent)
  if exponent < 0
    base = 1.0 / base
    exponent = -exponent
  elsif exponent == 0
    return 1
  end

  result = 1
  divisor, remainder = exponent.divmod 2
  divisor.times { result *= multiply(base, base) }
  result *= base if remainder == 1
  result
end

p (power(5, -3) - 0.008).abs < 0.00001
p (power(5, -2) - 0.04).abs < 0.00001
p (power(5, -1) - 0.2).abs < 0.00001
p power(5, 0) == 1
p power(5, 1) == 5
p power(5, 2) == 25
p power(5, 3) == 125
p power(5, 4) == 625

=begin

Solution

def square(n)
  multiply(n, n)
end

Discussion

Our implementation relies on the previous exercise's multiply method.
The return value of multiply is the result of multiplying the two
arguments we pass to it, so we can simply pass in the same number
twice, which will return the squared value. Our square method is
implicitly returning the return value from multiply(n, n).

Further Exploration

What if we wanted to generalize this method to a "power to the n"
type method: cubed, to the 4th power, to the 5th, etc. How would
we go about doing so while still using the multiply method?

See above

=end