=begin

After Midnight (Part 1)

The time of day can be represented as the number of minutes before or
after midnight. If the number of minutes is positive, the time is after
midnight. If the number of minutes is negative, the time is before midnight.

Write a method that takes a time using this minute-based format and returns
the time of day in 24 hour format (hh:mm). Your method should work with any
integer input.

You may not use ruby's Date and Time classes.

Examples:

time_of_day(0) == "00:00"
time_of_day(-3) == "23:57"
time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"

Disregard Daylight Savings and Standard Time and other complications.

=end

=begin
Problem
- input: any integer, positive or negative
- output: time string in 24 hr format "HH:MM"

Examples
- See above
- Duration can exceed 1 day, +/- 60*24 = 1440 mins

Data Structure
- input: signed integer
- output: String
- intermediary:

Algorithm
thoughts: need to get the sign, every 60 mins = 1 hour
For positive number, say 500 mins. 500.divmod 60 = (8, 20)
- first number add to the hours section, second number to mins second
- first number should modulo 24 for a single day. e.g 5000.divmod 60 = (83, 20). 83/24 = 11 => (11,20)

For negative number, 
- -500 = (8, 20) before midnight => (24-8-ceiling(20/60), 60-20) => (15, 40)
- -5000 = (83, 20) = 3 days and (11, 20) before midnight => (24-11-ceiling(20/60), 60-20) = (12, 40)
- -500.divmod(60) => [-9, 40] => [-9%24, 40] => [15, 40]
- -5000.divmod(60) => [-84, 40] => [-84%24, 40] => [12, 40] (we use % rather than remainder as we want to 
compensate by 1 day to get a positive number for 24 time format)

1 input.divmod(60) to get (hrs, min). hrs modulo 24
2. If input > 0, hrs = hrs, mins = min
3. If input < 0, hrs = 24-hrs-ceiling of min/60.0, min = 60 - min

=end

def time_of_day(number)
  hour, minute  = number.divmod(60)
  hour = hour % 24
  "%02d:%02d" % [hour, minute] 
end
  

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"


# Exploration 1

def normalize(minutes)
  

=begin

Solution

MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def normalize_minutes_to_0_through_1439(minutes)
  while minutes < 0
    minutes += MINUTES_PER_DAY
  end

  minutes % MINUTES_PER_DAY
end

def time_of_day(delta_minutes)
  delta_minutes = normalize_minutes_to_0_through_1439(delta_minutes)
  hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, minutes)
end

Discussion

We start out this solution by defining a few useful constants so we don't
have a bunch of mystery numbers in our method. The most important one we're
concerned of is MINUTES_PER_DAY, which has a value of 1440 (24 * 60 == 1440).

Our solution now boils down to 3 main operations:

    The most interesting -- and difficult -- part of this program is
    normalizing the argument so that we only have to deal with values
    that represent part of a single day. See below for why we do that.
    Once we've normalized the number of minutes, we can use Integer#divmod
    to determine the how many hours and minutes are represented by that
    value.
    Finally, we use the hours and minutes to format the time of day.

The fact that delta_minutes can be outside the range 0-1439 minutes makes
this problem more complex than it seems. However, if you think about the
problem for a few minutes, you may realize that there is something we can
do to make our job easier. We can normalize the number of minutes so that
we only have to deal with values that are positive but less than a full
day: 0-1439.

Consider for instance, the time of day 3 minutes before midnight
(delta_minutes == 3). That's the same time of day as 1437 minutes after
midnight (MINUTES_PER_DAY - 3 == 1437). On the other hand, the time of
day 1443 minutes past midnight is the same as the time of day 3 minutes
past midnight (MINUTES_PER_DAY - 1440 == 3). The 
#normalize_minutes_to_0_through_1439 method restricts each argument to
this range without changing the expected results.

If delta_minutes is greater than or equal to 0, we can normalize it easily
enough by computing the remainder of dividing delta_minutes by MINUTES_PER_DAY,
which we do on line 10. Lines 6-8 won't have any effect on these values of
delta_minutes, so we should now have the normalized number of minutes.

If delta_minutes is less than 0, normalization is a little more complex,
but not by much. All we have to do is add 1440 minutes to the argument's
value repeatedly until the value is no longer negative. Thus, -2500 is
normalized to 380 (-2500 + 1440 == -1060; -1060 + 1440 == 380; 380 >= 0).
Once we have a normalized value, we're done. We could return the value as-is
at this point, but we can simplify the code a bit by just treating the
normalized value as a normal non-negative value; it doesn't change anything,
but eliminates extra code.

Further Exploration

Problem 1

The % operator's interaction with negative values is confusing and difficult
to remember, as described in the Introduction to Programming with Ruby Book.
Because of that, we recommend not using % with negative numbers, but that you
should first convert the negative values to positive numbers so you can write
more explicit code. This problem is one such place where it's probably easier
to take this approach.

However, that doesn't mean you can't use % at all. In fact, it's possible to
write a single calculation with % that performs the entire normalization
operation in one line of code. Give it a try, but don't spend too much time
on it.

Problem 2

How would you approach this problem if you were allowed to use ruby's Date and
Time classes?

Problem 3

How would you approach this problem if you were allowed to use ruby's Date and
Time classes and wanted to consider the day of week in your calculation?
(Assume that delta_minutes is the number of minutes before or after midnight
between Saturday and Sunday; in such a method, a delta_minutes value of -4231
would need to produce a return value of Thursday 01:29.)

=end

=begin
TO REVIEW

https://launchschool.com/books/ruby/read/basics#divisionvsmodulo

- divmod (divisor is positive if both caller and argument have same sign, both positive
or both negative, else negative. remainder follows sign of argument)
10.divmod(3) => [3, 1]
-10.divmod(3) => [-4, 2] and not [-3, -1]
10.divmod(-3) => [-4, -2] and not [-3, 1]
-10.divmod(-3) => [3, -1]

- remainder (no matter the sign of calling integer, the result follows the sign of the caller)
10.remainder(3) => 1
-10.remainder(3) => -1
10.remainder(-3) => 1
-10.remainder(-3) => -1

- modulo (%) (no matter the sign of calling integer, the result follows the sign of the argument to divmod)
10%3 => 1
(-10)%3 => 2 and not -1
10%(-3) => -2 and not 1
(-10)%(-3) => -1


- format

Key concept from suggested solution: Instead of handling both positive and negative conversion, 
which i tried to do and highly confusing, we can convert to a single sign i.e. positive by rounding x days prior and 
then solve from there. That is easily and less confusing.

=end