=begin

Multiplying Two Numbers

Create a method that takes two arguments, multiplies them together,
and returns the result.

Example:

multiply(5, 3) == 15

=end

def multiply(first_number, second_number)
  first_number * second_number
end

p multiply(5, 3) == 15


=begin

Solution

def multiply(n1, n2)
  n1 * n2
end

Discussion

There are a couple of points of interest for this solution.

    Focus on the return value. Consider the below incorrect implementation.

def multiply(n1, n2)
  puts n1 * n2
end

multiply(1, 2) # returns nil

If you run the code above, you may think that this method fulfills the
requirements of the exercise, but it doesn't. It's important to remember
to focus on the method's return value and not its output. Also, keep in
mind that puts returns nil,and the above incorrect implementation will
always return nil.

The current implementation uses the * operator, which behaves differently
depending on what the left hand expression is. For example:

5 * 2       # => 10
"hi" * 2   # => "hihi"

    Therefore, our method implementation also suffers from this behavior
    since we're using the * operator.

Further Exploration

For fun: what happens if the first argument is an Array? What do you think
is happening here?

It will repeat the elements in the array depending on the 2nd operand
e.g. [1, 2] * 3 == [1, 2, 1, 2, 1, 2]

=end