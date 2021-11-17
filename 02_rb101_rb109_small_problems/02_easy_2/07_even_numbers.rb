=begin

Even Numbers

Print all even numbers from 1 to 99, inclusive, to the console, with
each number on a separate line.

=end

# Using Integer#upto and Integer#even?
1.upto(99) { |num| puts num if num.even? } # returns 1

# Using Integer#upto, select/filter and Integer#even?
puts (1..99).select(&:even?) # returns nil
puts (1..99).filter(&:even?)

# Using Integer#upto and Modulo
1.upto(99) { |num| puts num if num % 2 == 0 } # returns 1

for i in (1..99) # returns range object 1..99
  puts i if i % 2 == 0
end


=begin

Solution

value = 1
while value <= 99
  puts value if value.even?
  value += 1
end

Discussion

Our solution is just a minor variation on the solution to print odd numbers. 
This time, though, we increment the value by 1 with every iteration, and only
print it if it is even.

=end