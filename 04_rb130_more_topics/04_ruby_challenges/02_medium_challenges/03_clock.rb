# rubocop:disable all
=begin

Clock

Create a clock that is independent of date.

You should be able to add minutes to and subtract minutes from the time
represented by a given clock object. Two clock objects that represent the
same time should be equal to each other.

You may not use any built-in date or time functionality; just use arithmetic
operations.
=end


=begin
Problem
- Define a clock class with following instance methods
  - add mins
  - subtract mins
  - two different clock objects with same time are equal
  - indepedent of date (not sure what it means now)

Examples and Test Cases
- Define a clock class
- Define an ::at class method at accepts and hour argument and optional a 
  minutes second argument. Minutes argument defaults to 0
- ::at class method returns an object that has an to_s method
- #to_s format the time into "HH:MM" with HH from 00-23 and MM from 00-59
- object returned by ::at has a #+ instance method that accepts an integer
  representing minutes to be added to object. The minutes here can be any range
  and have to be wrapped around in HH:MM post addition where HH 00-23, MM 00-59
- object returned by ::at has a #- instance method that accepts an integer
  representing minutes to be subtracted from object. The minutes here can be 
  any range and have to be wrapped around in HH:MM post subtraction where 
  HH 00-23, MM 00-59
- An #== method that returns true if both clock objects have same time but
  can be different objects.
  
Data Structures
- Maybe an array storing 2 elements holding the time in hours and minutes
- Hours and mins represented by integers and math operation to do the wrap 
  around
  
Algorithm

initialize(hr, min)
1. Set @hr = hr
2. set @min = min
wrap_time

::at(hr, min = 0)
1. create and returns a new clock instance using ::new(hr, min)

#+(min)
- if min < 0, return - (absolute min)
- @min += min
- wrap_time

#-(min)
- if min < 0, return + (absolute min)
- @min -= min
- wrap_time

#to_s
- "#{@hr}:#{@min}"

#==(other)
- to_s == other.to_s

wrap_time helper method
- hr_roll_over, @min = @min.divmod(60) 
- @hr += hr_roll_over
- @hr = @hr % 24

=end
# rubocop:enable all

class Clock
  def self.at(hr, min = 0)
    new(hr, min) # self prefix is needed before Ruby 2.7.0
  end

  def initialize(hr, min)
    @hour = hr
    @minute = min

    wrap_time
  end

  def +(given_minutes)
    return -(given_minutes.abs) if given_minutes < 0
    self.minute += given_minutes

    wrap_time
  end

  def -(given_minutes)
    return +(given_minutes.abs) if given_minutes < 0
    self.minute -= given_minutes

    wrap_time
  end

  def to_s
    format('%02d:%02d', hour, minute)
  end

  def ==(other)
    to_s == other.to_s
  end

  private

  attr_accessor :hour, :minute

  def wrap_time
    carried_over_hour, wrapped_minutes = minute.divmod(60)
    self.minute = wrapped_minutes
    self.hour += carried_over_hour
    self.hour = hour % 24

    self
  end
end

# rubocop:disable all
=begin
PEDAC Solution


Understanding the Problem
  For our program, the details we need to keep in mind are as follows:

    Our clock objects should track hours and minutes.
    
    We should be able to add minutes to and subtract minutes from our
    clock objects.
    
    If two clock objects have the same time (both hour and minutes), they
    should be considered equal.
    
    We may want our clock object to use 24-hour notation rather than 12-hour
    notation since we only need to track hours and minutes, not the date.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create a
  Clock class. The class should have several methods as follows:

    a constructor that accepts two number arguments representing the hour
    and minutes.
    
    a class or static method named at that can create and return a new
    instance of Clock. If the minutes argument is omitted, a default value
    of 0 will be used.
    
    a method that returns the clock's current time as a string.
    
    methods that add and subtract from the current time. These methods accept
    a number of minutes to add or subtract as an argument.
    
    a method that compares two clock objects for equality.

  We may also want to create some helper methods to assist us, but those
  are optional.


Data Structures
  The hours and minutes will be represented with numbers, and we will be
  working with numbers each time we add or subtract from the time.

  The method that returns the clock's current time as a string must convert
  the hour and minutes to a string that is formatted properly: XX:XX.
  

Hints and Questions
  The at class/static method can create a new Clock instance using the Clock
  constructor. Use a default value of 0 for the minutes if the minute argument
  is omitted from the call to at.


Hints and Questions - Ruby
  You will need to override the + and - methods in the Clock class. Both
  operators take a Clock object operand on the left side of the operator,
  and a number of minutes to the right. They should not mutate the Clock
  object, and both should return a new Clock object.

  You need to override the == method in the Clock class so that assert_equal
  and refute_equal work properly.

  You also need to override the to_s method to format the time represented by
  a Clock object as XX:XX.


Algorithm

    constructor
        Save the hours and minutes.
        There is no need to validate the arguments.

    Static/Class Method: at
        Use a default value of 0 for the minutes if the 2nd argument is omitted.
        Call constructor to create a new object.
        Return the new object.

    Method: Add Minutes to Clock (Ruby: +; JavaScript: add)
        Compute minutes since midnight for Clock object: use helper method 
        "compute minutes since midnight".
        
        Add minutes argument to minutes since midnight.
        
        While (minutes since midnight >= 24 * 60)
            Subtract 24 * 60 from minutes since midnight
        
        Determine time represented by minutes since midnight: use helper method
        "compute time from minutes since midnight"
        
        Return value returned by previous step.

    Method: Subtract Minutes from Clock (Ruby: -; JavaScript: subtract)
        Compute minutes since midnight for Clock object: use helper method 
        "compute minutes since midnight".
        
        Subtract minutes argument from minutes since midnight.
        
        While (minutes since midnight < 0)
            Add 24 * 60 from minutes since midnight
        
        Determine time represented by minutes since midnight: use helper method
        "compute time from minutes since midnight"
        
        Return value returned by previous step.

    Method: Determine Equality for two Clock Objects 
    (Ruby: ==; JavaScript: isEqual)
        If both Clock objects have the same hours and minutes values, 
        return true. Otherwise, return false.

    Method: Return string representation of Clock object 
    (Ruby: to_s; JavaScript: toString)
        Format hours and minutes as HH:MM where HH and MM are both two digit
        numbers. If necessary, they should have leading zeros.

    Helper method: compute minutes since midnight
        Return 60 * hours + minutes where hours and minutes are from the
        current Clock object.

    Helper method: compute time from minutes since midnight
        One argument: minutes since midnight.
        See hints for the language of your choice.
        Return a new Clock object representing the computed time.
        

Ruby Solution and Discussion

class Clock
  attr_reader :hour, :minute

  ONE_DAY = 24 * 60

  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    new(hour, minute)
  end

  def +(add_minutes)
    minutes_since_midnight = compute_minutes_since_midnight + add_minutes
    while minutes_since_midnight >= ONE_DAY
      minutes_since_midnight -= ONE_DAY
    end

    compute_time_from(minutes_since_midnight)
  end

  def -(sub_minutes)
    minutes_since_midnight = compute_minutes_since_midnight - sub_minutes
    while minutes_since_midnight < 0
      minutes_since_midnight += ONE_DAY
    end

    compute_time_from(minutes_since_midnight)
  end

  def ==(other_time)
    hour == other_time.hour && minute == other_time.minute
  end

  def to_s
    format('%02d:%02d', hour, minute);
  end

  private

  def compute_minutes_since_midnight
    total_minutes = 60 * hour + minute
    total_minutes % ONE_DAY
  end

  def compute_time_from(minutes_since_midnight)
    hours, minutes = minutes_since_midnight.divmod(60)
    hours %= 24
    new(hours, minutes)
  end
end

In the constructor, we simply save the two arguments representing the hour
and minute values as attributes in the newly created Clock object.

In the class method at, a default value of 0 is provided to the parameter
minute. The new invokes the Clock class's constructor with the hour and
minute values, and returns the resulting object.

+ and - are the most difficult pieces of logic to implement for this program.
While its possible to write both of these methods by operating directly on
the hour and minute attributes, this is clumsy and difficult. It's easier to
compute the time in minutes since midnight, and then operate on those values.
We use the compute_minutes_since_midnight method to perform this calculation.
Note that we ensure the returned value is between 0 and 1439, inclusive
(there are 1440 minutes in a day).

After adding or subtracting the number of minutes from minutes_since_midnight,
we then make sure the result is again in the range of 0 through 1439. We can
use minutes_since_midnight %= 24 instead of the loop in the + method, but the
presence of negative numbers in - makes us more cautious. For consistency, we
use a loop in both places.
=end


=begin
- + and - instance methods return a new object rather than overwrite existing
  object. This is main difference between my solution and given solution

- Logic is much easier to understand performing addition and subtraction in 
  minutes than converting it back to hours and minutes
  
- My solution handles weird inputs (-ve values arguments etc)
=end