=begin

Countdown

Our countdown to launch isn't behaving as expected. Why? Change the code
so that our program successfully counts down from 10 to 1.

def decrease(counter)
  counter -= 1
end

counter = 10

10.times do
  puts counter
  decrease(counter)
end

puts 'LAUNCH!'
=end

=begin
My answer:
counter initialized in line 12 is different from the counter in the method `decrease`
which has a local scope. Hence even though we reassign the local scoped `counter`
within `decrease` its value less 1, its scope is local and will be lost once the 
method returns. Also even though `decrease` returns the updated value, it is not be
used. To fix that, we need to assign the its return value to the counter variable again.
=end

def decrease(counter)
  counter -= 1
end

counter = 10

while counter > 0
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'


=begin
Solution

def decrease(counter)
  counter - 1
end

counter = 10

10.times do
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'

Discussion

Revelant to notice here is that the counter variable initialized on line 5 and
the counter parameter of the decrease method are two independent variables.
Most importantly, the latter lives only within the scope of the method. On
line 2 of our original code snippet we reassign the method parameter to the
result of its value minus 1. (Recall that counter -= 1 is shorthand for
counter = counter - 1.) This changes the value of the counter variable local
to the method, but not the variable counter referenced on lines 5, 8 and 9.
We also don't use the return value of the method anywhere, so our counter
variable outside of the method continues to reference the Integer 10.

To address this, we can reassign the variable counter on line 9 to the return
value of decrease(counter) each time we iterate through the block. For clarity,
we also remove the reassignment in the decrease method, as it does not serve
any purpose.

Further Exploration

We specify 10 two times, which looks a bit redundant. It should be possible to
specify it only once. Can you refactor the code accordingly?
=end


=begin
TO REVIEW
- even though using counter -= 1 generate the same result, we should refactor
  it to counter - 1 for clarity of intention since the reassignment serves no 
  purpose
=end  