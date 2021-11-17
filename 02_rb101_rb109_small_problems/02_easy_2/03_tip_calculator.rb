=begin


Tip calculator

Create a simple tip calculator. The program should prompt for a bill amount
and a tip rate. The program must compute the tip and then display both the
tip and the total amount of the bill.

Example:

What is the bill? 200
What is the tip percentage? 15

The tip is $30.0
The total is $230.0

=end

print "What is the bill? "
bill = gets.chomp.to_f
puts "What is the tip percentage? "
tip_percent = gets.chomp.to_f / 100

tip = (bill * tip_percent).round(1)
total = (bill + tip).round(1)

puts "The tip is $#{tip}"
puts "The total is $#{total}"


=begin

Solution

print 'What is the bill? '
bill = gets.chomp
bill = bill.to_f

print 'What is the tip percentage? '
percentage = gets.chomp
percentage = percentage.to_f

tip   = (bill * (percentage / 100)).round(2)
total = (bill + tip).round(2)

puts "The tip is $#{tip}"
puts "The total is $#{total}"

Discussion

We first obtain the amount of the bill from the user, not worrying
too much about data validity for this simple problem. Then we get
the tip percentage.

Next, we calculate the actual tip, and the total bill, then output
the results.

Further Exploration

Our solution prints the results as $30.0 and $230.0 instead of the
more usual $30.00 and $230.00. Modify your solution so it always
prints the results with 2 decimal places.

Hint: You will likely need Kernel#format for this.

# TO REVIEW:
- Use print instead of puts to print to screen without newline.

=end