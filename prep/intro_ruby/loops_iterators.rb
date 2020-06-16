=begin

A for loop returns the collection of elements after it executes, whereas a while loop examples return nil

y = for i in 1..10 do
  puts i
end

Note: y will be assigned 1..10, a collection as it is returned by the for loop

z = while x >= 0
  puts x
  x = x - 1
end

Note: z will be assigned nil by the while loop

=end


=begin
What does the each method in the following program return after it is finished executing?

x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end

Answer: each returns the full list of elements i.e. [1, 2, 3, 4, 5]
=end


# Write a while loop that takes input from the user, performs an action, and only stops 
# when the user types "STOP". Each loop can get info from the user.

print "Enter a word, STOP to quit:"
input = gets.chomp
while input != "STOP"
  puts "You entered #{input}!"
  puts "Enter another word, STOP to quit:"
  input = gets.chomp
end



# Write a method that counts down to zero using recursion.
def count_down(num)
  if num >= 0
    puts num
    count_down(num-1)
  end
end

print "Enter an integer to start countdown:"
start_num = gets.chomp.to_i
count_down(start_num)