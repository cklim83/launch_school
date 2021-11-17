=begin

How big is the room?

Build a program that asks a user for the length and width of a room in meters
and then displays the area of the room in both square meters and square feet.

Note: 1 square meter == 10.7639 square feet

Do not worry about validating the input at this time.

Example Run

Enter the length of the room in meters:
10
Enter the width of the room in meters:
7
The area of the room is 70.0 square meters (753.47 square feet).

=end

puts "Enter the length of the room in meters:"
length_m = gets.chomp.to_f
puts "Enter the width of the room in meters:"
width_m = gets.chomp.to_f

area_sqm = (length_m * width_m).round(2)
area_sqft = (area_sqm * 10.7639).round(2)

puts "The area of the room is #{area_sqm} square"\
     " meters (#{area_sqft.round(2)} square feet)."


=begin

Solution

SQMETERS_TO_SQFEET = 10.7639

puts '==> Enter the length of the room in meters: '
length = gets.to_f

puts '==> Enter the width of the room in meters: '
width = gets.to_f

square_meters = (length * width).round(2)
square_feet = (square_meters * SQMETERS_TO_SQFEET).round(2)

puts "The area of the room is #{square_meters} " + \
     "square meters (#{square_feet} square feet)."

Discussion

Our solution is straightforward. First we obtain the length, then we get the
width. Next we perform our calculations, and then we print the results. We do
no validation on our inputs, and just assume the user will enter appropriate
values.

We use a constant, SQMETERS_TO_SQFEET to store the conversion factor between
square meters and square feet. This is good practice any time you have a number
whose meaning is not immediately obvious upon seeing it.

The only thing that may be unfamiliar here is the round method (a method of
the Float class), which is used to round our results to the nearest 2 decimal
places. (You can also use Kernel#format to format the results, but format is
harder to use.)

Further Exploration

Modify this program to ask for the input measurements in feet, and display the
results in square feet, square inches, and square centimeters.


TO REVIEW: 
- Use constant variables wheneven appropriate
- Float#round

https://docs.ruby-lang.org/en/2.6.0/Float.html#method-i-round
round([ndigits] [, half: mode]) → integer or float

Returns float rounded to the nearest value with a precision of ndigits decimal digits (default: 0).

When the precision is negative, the returned value is an integer with at least ndigits.abs trailing zeros.

Returns a floating point number when ndigits is positive, otherwise returns an integer.

1.4.round      #=> 1
1.5.round      #=> 2
1.6.round      #=> 2
(-1.5).round   #=> -2

1.234567.round(2)   #=> 1.23
1.234567.round(3)   #=> 1.235
1.234567.round(4)   #=> 1.2346
1.234567.round(5)   #=> 1.23457

34567.89.round(-5)  #=> 0
34567.89.round(-4)  #=> 30000
34567.89.round(-3)  #=> 35000
34567.89.round(-2)  #=> 34600
34567.89.round(-1)  #=> 34570
34567.89.round(0)   #=> 34568
34567.89.round(1)   #=> 34567.9
34567.89.round(2)   #=> 34567.89
34567.89.round(3)   #=> 34567.89

- check out Kernel#format and earlier assignments on how format can be used
https://docs.ruby-lang.org/en/2.6.0/Kernel.html#method-i-format

=end