=begin

Cute angles

Write a method that takes a floating point number that represents an angle
between 0 and 360 degrees and returns a String that represents that angle
in degrees, minutes and seconds. You should use a degree symbol (°) to
represent degrees, a single quote (') to represent minutes, and a double
quote (") to represent seconds. A degree has 60 minutes, while a minute
has 60 seconds.

Examples:

dms(30) == %(30°00'00")
dms(76.73) == %(76°43'48")
dms(254.6) == %(254°36'00")
dms(93.034773) == %(93°02'05")
dms(0) == %(0°00'00")
dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

Note: your results may differ slightly depending on how you round values,
but should be within a second or two of the results shown.

You should use two digit numbers with leading zeros when formatting the
minutes and seconds, e.g., 321°03'07".

You may use this constant to represent the degree symbol:

DEGREE = "\xC2\xB0"

=end

=begin
Problem
- input: float representing an angle between 0 and 360
- output: string in degrees, minuts and seconds representing input angles
          use degree symbol (°) for degrees
          single quote (') for minutes
          double quote (") for seconds
          1 degree = 60 minutes
          1 minute = 60 seconds
          

Examples
- See above
- method name is `dms`
- Whole numbers = degrees
- dms(76.73) == %(76°43'48")
    - 0.73 degree = 0.73 * 60 * 60 seconds
                  = 2628 seconds
    - 2628.divmod 60 = [43, 48]
                     = 43 mins, 48 seconds
- dms(254.6) == %(254°36'00")
    - (0.6 * 3600).divmod(60) = [36, 0]
- dms(93.034773) == %(93°02'05")
    - (0.034773*3600).divmod(60) = [2, 5.1828]
    - implicit reqt: minutes should round to nearest integer
- dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
    - implicit reqt: results can roll over every 360 degree
- Other questions: can input be negative and can we handle by 
                   converting it to positive by rolling over 360?
                   e.g. -364.3 = -364.3 + 2*360 = 355.7?
- use two digit numbers with leading zeros when formatting the
minutes and seconds, e.g., 321°03'07".
- DEGREE = "\xC2\xB0"

Data Structure:
- input: Float
- output: String
- Intermediary: Probably Float or Integer

Algorithm
- if input is negative, convert it to positive
- Assign whole number as degrees
- Take decimal, multiply by 60*60 then divmod 60
- Assign first element to minutes
- Round second element to nearest integer and assign to seconds
- Format string "#{degrees}#{DEGREE}#{minutes}'#{seconds}" with 2 digits 
  for minutes and seconds
- Return result

=end

DEGREE = "\xC2\xB0"
MINUTE_TO_SECONDS = 60
DEGREE_TO_SECONDS = 3600

def right_range(angle)
  loop do
    break if angle >= 0 && angle < 360
    if angle < 0 
      angle += 360
    elsif angle >= 360
      angle -= 360
    end
  end
  
  angle
end

def dms(angle)
  angle = right_range(angle)
  degrees, subdegree = angle.divmod(1) 
  minutes, seconds = (subdegree*DEGREE_TO_SECONDS).divmod(MINUTE_TO_SECONDS)
  seconds = seconds.round # round to nearest integer
  if seconds == 60 # for rounding edge cases
    seconds = 0
    minutes += 1
  end
  "#{degrees}#{DEGREE}%02d'%02d\"" % [minutes, seconds]
end

# Test cases
p (right_range(-30.56) - 329.44).abs < 0.001
p (right_range(750.53) - 30.53).abs < 0.001
p dms(30) == %(30°00'00")
p dms(76.73) == %(76°43'48")
p dms(254.6) == %(254°36'00")
p dms(93.034773) == %(93°02'05")
p dms(0) == %(0°00'00")
p dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

=begin
Solution

DEGREE = "\xC2\xB0"
MINUTES_PER_DEGREE = 60
SECONDS_PER_MINUTE = 60
SECONDS_PER_DEGREE = MINUTES_PER_DEGREE * SECONDS_PER_MINUTE

def dms(degrees_float)
  total_seconds = (degrees_float * SECONDS_PER_DEGREE).round
  degrees, remaining_seconds = total_seconds.divmod(SECONDS_PER_DEGREE)
  minutes, seconds = remaining_seconds.divmod(SECONDS_PER_MINUTE)
  format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds)
end

Discussion

We start by defining some useful constants - including the supplied
DEGREE constant. These constants aren't essential, but they help with
understanding what is going on in each step.

The method starts out by converting the number of degrees to seconds;
this makes it easier to compute the whole number of degrees, minutes,
and seconds. Next, we use divmod to get the whole number of degrees,
and a remainder that represents the number of seconds in the fractional
part of the original value. We then use divmod again to split the
remainder into a whole number of minutes, and a whole number of seconds.
The final step puts everything together with #Kernel.format.

It's worth noting that the desired output contains both single and
double quote characters. Ruby provides a variety of ways to deal with
quotes inside strings; the easiest uses %(), %q() or %Q() to delimit
the string. We use %() here.

Further Exploration

Our solution returns the following results for inputs outside the range 0-360:

dms(400) == %(400°00'00")
dms(-40) == %(-40°00'00")
dms(-420) == %(-420°00'00")

Since degrees are normally restricted to the range 0-360, can you modify
the code so it returns a value in the appropriate range when the input is
less than 0 or greater than 360?

dms(400) == %(40°00'00")
dms(-40) == %(320°00'00")
dms(-420) == %(300°00'00")
=end

=begin
TO REVIEW:
- Rounding errors failing p dms(254.6) == %(254°36'00")

=end