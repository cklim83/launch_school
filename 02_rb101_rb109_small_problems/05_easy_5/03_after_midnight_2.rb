=begin

After Midnight (Part 2)

As seen in the previous exercise, the time of day can be represented as the
number of minutes before or after midnight. If the number of minutes is
positive, the time is after midnight. If the number of minutes is negative,
the time is before midnight.

Write two methods that each take a time of day in 24 hour format, and return
the number of minutes before and after midnight, respectively. Both methods
should return a value in the range 0..1439.

You may not use ruby's Date and Time methods.

Examples:

after_midnight('00:00') == 0
before_midnight('00:00') == 0
after_midnight('12:34') == 754
before_midnight('12:34') == 686
after_midnight('24:00') == 0
before_midnight('24:00') == 0

Yes, we know that 24:00 isn't a valid time in 24-hour format. Humor us,
though; it makes the problem more interesting.

Disregard Daylight Savings and Standard Time and other irregularities.

=end

=begin
Problem
- input: String in 24hr format HH:MM
- output: Integer from 0 to 1439

Examples
- See above
- Edge case '24:00' will result in 0 and not 1440

Data Structure
- input: String
- Output: Integer

Algorithm

after_midnight
- (hours * 60 + minutes) % 1440

before_midnight
- shift one day prior: 
  - hour_adjustment, minutes = -minutes.divmod(60)
  - _, hours = -hours.divmod(24)
  - hours = hours + hour_adjustment
  - format("02d:02d", [hours, minutes])
- use after_midnight

=end

MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = MINUTES_PER_HOUR * HOURS_PER_DAY

def after_midnight(time_str)
  hours, minutes = time_str.split(":")
  (hours.to_i * MINUTES_PER_HOUR + minutes.to_i) % MINUTES_PER_DAY
end

def before_midnight_to_after_midnight(time_str)
  hours, minutes = time_str.split(":")
  hour_adjustment, minutes = (-minutes.to_i).divmod(MINUTES_PER_HOUR)
  _, hours = (-hours.to_i).divmod(24) # first result is actually days_ago
  hours = hours + hour_adjustment
  after_midnight_time_str = format("%02d:%02d", hours, minutes)
end

def before_midnight(time_str)
  after_midnight_time_str = before_midnight_to_after_midnight(time_str)
  after_midnight(after_midnight_time_str)
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0


=begin

Solution

HOURS_PER_DAY = 24
MINUTES_PER_HOUR = 60
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def after_midnight(time_str)
  hours, minutes = time_str.split(':').map(&:to_i)
  (hours * MINUTES_PER_HOUR + minutes) % MINUTES_PER_DAY
end

def before_midnight(time_str)
  delta_minutes = MINUTES_PER_DAY - after_midnight(time_str)
  delta_minutes = 0 if delta_minutes == MINUTES_PER_DAY
  delta_minutes
end

Discussion

As with the previous problem, we start with some useful constant definitions.

The after_midnight method is simple enough; we simply have to split the time
strings into hours and minutes, then calculate the result in minutes.

You might be puzzled by .map(&:to_i); it's a shorthand way of doing this:

something.map { |string| string.to_i }

In the last statement of after_midnight, we need to use % MINUTES_PER_DAY to
handle a simple edge case. In the given time format, 00:00 and 24:00 are the
same. However, the way we implemented after_midnight calculates these as
different times. We use the modulo operator (%) and MINUTES_PER_DAY to divide
the calculated minutes by the number of minutes in a day, then return the
remainder, which will be 0 for both 00:00 and 24:00.

before_midnight reuses after_midnight by simply subtracting the return value
of after_midnight from MINUTES_PER_DAY. This does have the unfortunate effect
of setting delta_minutes to 1440 when we want 0, so the statement after simply
fixes that.

Further Exploration

How would these methods change if you were allowed to use the Date and Time
classes?


TO REVIEW:
- .map(&:to_i) == something.map { |string| string.to_i }
- Wrapping time
- Date and Time classes

=end