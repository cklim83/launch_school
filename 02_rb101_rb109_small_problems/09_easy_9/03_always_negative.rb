=begin

Always Return Negative

Write a method that takes a number as an argument. If the argument
is a positive number, return the negative of that number. If the
number is 0 or negative, return the original number.

Examples:

negative(5) == -5
negative(-3) == -3
negative(0) == 0      # There's no such thing as -0 in ruby
=end

def negative(number)
  number = - number if number > 0
  number
end

p negative(5) == -5
p negative(-3) == -3
p negative(0) == 0      # There's no such thing as -0 in ruby

=begin
Solution

def negative(number)
  number > 0 ? -number : number
end

Discussion

There are only two choices here. Either make the number negative and return
it or return the already negative number. This is the perfect place for a
ternary.

The condition will check if the number is greater than zero. If so make it
negative and return it; otherwise, return the already negative number.

Further Exploration

There is an even shorter way to write this but it isn't as immediately intuitive.
=end