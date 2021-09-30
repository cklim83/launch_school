=begin

1) What does the each method in the following program return after it is finished executing?

x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end

=end

# Each method returns the array itself after it finished executing
# Proof

nums = [1, 2, 3]
temp = nums.each { |x| puts }
temp << 'a' # append 'a' to the array returns by each
puts temp
puts nums  # nums also contain 'a'


=begin

2) Write a while loop that takes input from the user, performs an action, 
and only stops when the user types "STOP". Each loop can get info from the user.

=end

while true
  puts "Please enter an input, STOP to quit: "
  input = gets.chomp
  
  if input == "STOP"
    break
  else
    puts "You entered #{input}!"
  end
end  


=begin

3) Write a method that counts down to zero using recursion.

=end

def countdown(num)
  if num >= 0
    puts num
    countdown(num-1)
  end
end

countdown(10)
countdown(-5)