=begin

From-To-Step Sequence Generator

The Range#step method lets you iterate over a range of values where each
value in the iteration is the previous value plus a "step" value. It
returns the original range.

Write a method that does the same thing as Range#step, but does not
operate on a range. Instead, your method should take 3 arguments: 
the starting value, the ending value, and the step value to be applied
to each iteration. Your method should also take a block to which it will
yield (or call) successive iteration values.

Example:

step(1, 10, 3) { |value| puts "value = #{value}" }

value = 1
value = 4
value = 7
value = 10

What do you think would be a good return value for this method, and why?
=end

def step(start_value, end_value, step)
  curr_value = start_value
  while curr_value <= end_value
    yield(curr_value)
    curr_value += step
  end
  
  (start_value..end_value)
end

step(1, 10, 3) { |value| puts "value = #{value}" }
# Return a range object to mimic the raturn value of Range#step


=begin
Solution

def step(start_point, end_point, increment)
  current_value = start_point
  loop do
    yield(current_value)
    break if current_value + increment > end_point
    current_value += increment
  end
  current_value
end

Discussion

In this solution start_point is where we begin, end_point is the maximum
value to step up to, and increment is the amount we want to step by on each
iteration.

current_value is yielded to the block and then incremented on each iteration.
We do not want to step beyond end_point, so we exit the loop when
current_value + increment > end_point. Finally, we return current_value.

There's no particular reason why we choose to return current_value other than
the fact that it is a reasonably sensible value. Range#step returns self (this
is, the original Range object), but that doesn't work for us. Another
reasonable return value might be nil, or perhaps the last value returned by the
block.
=end