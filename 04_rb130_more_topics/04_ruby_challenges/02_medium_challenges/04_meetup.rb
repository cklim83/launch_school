# rubocop:disable all
=begin
Meetups are a great way to meet people who share a common interest. Typically,
meetups happen monthly on the same day of the week. For example, a meetup's
meeting may be set as:

    The first Monday of January 2021
    The third Tuesday of December 2020
    The teenth wednesday of December 2020
    The last Thursday of January 2021

In this program, we'll construct objects that represent a meetup date. Each
object takes a month number (1-12) and a year (e.g., 2021). Your object should
be able to determine the exact date of the meeting in the specified month and
year. For instance, if you ask for the 2nd Wednesday of May 2021, the object
should be able to determine that the meetup for that month will occur on the
12th of May, 2021.

The descriptors that may be given are strings: 'first', 'second', 'third',
'fourth', 'fifth', 'last', and 'teenth'. The case of the strings is not
important; that is, 'first' and 'fIrSt' are equivalent. Note that "teenth"
is a made up word. There was a meetup whose members realised that there are
exactly 7 days that end in '-teenth'. Therefore, it's guaranteed that each
day of the week (Monday, Tuesday, ...) will have exactly one date that is the
"teenth" of that day in every month. That is, every month has exactly one
"teenth" Monday, one "teenth" Tuesday, etc. The fifth day of the month may
not happen every month, but some meetup groups like that irregularity.

The days of the week are given by the strings 'Monday', 'Tuesday', 'Wednesday',
'Thursday', 'Friday', 'Saturday', and 'Sunday'. Again, the case of the strings
is not important.
=end


=begin
Problem
- Given the following inputs:
  - integer: month
  - integer: year
  - string: descriptors (case insensitive) 
  - string: day of the week (case insensitive)
- Return a meetup object of the required date
- Note: fifth day of the week may not be applicable for every month


Examples and Test Cases
- Define a Meetup class with the following:
    - A constructor taking 2 integers: year then month 
    - a day method taking two strings: Day of week, then descriptor, returning 
      a date object denoting the right calendar date.
    - the day method is case insensitive with regards to the argument string
    - for descriptor "fifth", return nil if such a date doesnt exist in 
      chosen month.
    - descriptors(case insensitive):
        - "first", "second", "third", "fourth", "fifth", "last" and "teenth"
    - day of week(case insensitive):
        - "monday", "tuesday", "wednesday", "thursday", "friday", "saturday",
          "sunday"


Data Structures
- integers for year and month and day of week
- strings for descriptors
- Dates and their methods
- Hash to match day of week to number
- Hash to match descriptor to number

Hints and Questions
- Need a way to determine whether a day_of_week string is
  first, second, third, fourth and fifth to week of the month

- Useful Date methods
  - mday -> Returns the day of the month (1-31).
  - cwday -> Returns the day of calendar week (1-7, Monday is 1).
  - next_day([n=1]) -> return a new date equivalent to d + n.
  

Algorithm

Constructor
- create and return a new meetup object with @year = year and @month = month

#day(day_of_week, description)
1. Concatenate day_of_week and description in lower case as required_description
2. Create date object using given year and month
3. Create day_of_week_history array to store day_of_week entries as we iterate
   each day in month
4. Iterate each date in current month as current_date
     - Create descriptions as empty arry to hold all description for
       current_date. Each date can have 1-3 descriptions:
         - "day_of_week" + /[first|second|third|fourth|fifth]"/
         - "day_of_week teenth" if date between 13 to 19
         - "day_of_week last" if date + 7 days = next month
         
     - Get day_of_week string for current_date and append to day_of_week_history
     - Pass day_of_week_history to generate_description helper method to get
       "day_of_week" + /[first|second|third|fourth|fifth]"/ description. Append
       description to descriptions array
     - Append "day_of_week teenth" if teenthy?(current_date) helper method
       returns true
     - Append "day_of_week last" if last?(current_date) helper method
       returns true
     - exit iteration if descriptions include required description
     - else iterate current_date to next date in month
5. If current_date is within same month as given month, return current_date
   Else return nil


generate_description(days_of_week) helper function
1.  str = ""
2.  day_of_week = days_of_week.last
3.  occurrences = count number of times day_of_week appear in days_of_week
4.  set str = case occurrences
            when 1 then 'first'
            when 2 then 'second'
            when 3 then 'third'
            when 4 then 'fourth'
            when 5 then 'fifth'
5.  return concatenation of day_of_week to str with space in middle

teenthy?(date) helper function
1. return is day of month of date between 13 and 19?

last?(date) helper function
1. return true if date + 7days enters a new month 
=end
# rubocop:enable all

require 'date'

class Meetup
  attr_reader :year, :month

  def initialize(year, month)
    @year = year
    @month = month
  end

  def day(dow_str, occurrence_str)
    current_date = Date.new(year, month, 1)
    next_month_date = current_date.next_month
    dow_history = []

    while current_date < next_month_date
      dow_history << get_dow_str(current_date)
      descriptions = compile_descriptions(dow_history, current_date)
      break if descriptions.include?("#{dow_str} #{occurrence_str}".downcase)
      current_date = current_date.next_day
    end

    current_date < next_month_date ? current_date : nil
  end

  private

  def compile_descriptions(dow_history, current_date)
    dow_str = dow_history.last

    descriptions = []
    descriptions << generate_description(dow_history)
    descriptions << dow_str + " teenth" if teenthy?(current_date)
    descriptions << dow_str + " last" if last?(current_date)

    descriptions
  end

  def get_dow_str(date)
    case date.cwday
    when 1 then 'monday'
    when 2 then 'tuesday'
    when 3 then 'wednesday'
    when 4 then 'thursday'
    when 5 then 'friday'
    when 6 then 'saturday'
    else 'sunday'
    end
  end

  def generate_description(dow_history)
    current_date_dow_str = dow_history.last
    occurrence_count = dow_history.count(current_date_dow_str)

    occurrence_str = case occurrence_count
                     when 1 then 'first'
                     when 2 then 'second'
                     when 3 then 'third'
                     when 4 then 'fourth'
                     when 5 then 'fifth'
                     end

    current_date_dow_str + " " + occurrence_str
  end

  def teenthy?(date)
    (13..19).include? date.mday
  end

  def last?(date)
    date.month != date.next_day(7).month
  end
end

# rubocop:disable all
=begin
PEDAC Solution

Understanding the Problem
  The details we need to keep in mind are as follows:

    - April, June, September, and November have 30 days.
    - February has 28 in most years, but 29 in leap years.
    - All the other months have 31 days.
    - The first day of the week of the month (DOWM) is always between the 1st
      and 7th of the month.
    - The second DOWM is between the 8th and 14th of the month.
    - The third DOWM is between the 15th and 21st of the month.
    - The fourth DOWM is between the 22nd and 28th of the month.
    - The fifth DOWM is between the 29th and 31st of the month.
    - The last DOWM is between the 22nd and the 31st of the month depending 
      on the number of days in the month.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create a
  Meetup class. The class should have 2 methods as follows:

    - a constructor that takes the year (e.g., 2020) and a month number (1-12)
    - a method that determines the date of the meetup in the specified year and
      month. This method takes a day of week (e.g., 'Monday' or 'Friday') and a
      schedule descriptor ('first', 'last', 'teenth', etc.) It returns the date
      as a Date object.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structures
  From the test cases, it looks like we will be working with Date objects in
  our language of choice.
  

Hints and Questions (General)
  - Determine the 7 day period in which the meetup will occur. See the
    PEDAC: Understanding the Problem section for the appropriate date ranges.
      
  - Search the range of dates that contain the meetup date for the date that
    matches the desired day of week.

Hints and Questions (Ruby)
  - Month numbers in Ruby Date objects range from 1 (January) to 12 (December).
  
  - To determine the number of days in a specific month, you don't have to know
  whether the year is a leap year, nor do you need to provide a list that shows
  the number of days in each month. You can determine the last day of the month
  by using the Date class by passing a day argument of -1 to the Date.civil
  method to create a Date object that represents the last day of the indicated
  year and month.


Algorithm
  Constructor

    constructor
        - Save the year and month
        - Determine the last day of the month (28-31) (see hint above)

    Method: day
        - Convert the weekday and schedule descriptor to lowercase.
        - Calculate the first possible day of the month for the meetup.
        - Calculate the last possible day of the month for the meetup.
        - Search the range of possible days for the date that occurs on the
          desired day of the week
        - Return a date object for the first matching day or a value that
          indicates that a meetup date couldn't be found.


Ruby Solution and Discussion

class Meetup
  SCHEDULE_START_DAY = {
    'first' => 1,
    'second' => 8,
    'third' => 15,
    'fourth' => 22,
    'fifth' => 29,
    'teenth' => 13,
    'last' => nil
  }.freeze

  def initialize(year, month)
    @year = year
    @month = month
    @days_in_month = Date.civil(@year, @month, -1).day
  end

  def day(weekday, schedule)
    weekday = weekday.downcase
    schedule = schedule.downcase

    first_possible_day = first_day_to_search(schedule)
    last_possible_day = [first_possible_day + 6, @days_in_month].min

    (first_possible_day..last_possible_day).detect do |day|
      date = Date.civil(@year, @month, day)
      break date if day_of_week_is?(date, weekday)
    end
  end

  private

  def first_day_to_search(schedule)
    SCHEDULE_START_DAY[schedule] || (@days_in_month - 6)
  end

  def day_of_week_is?(date, weekday) # rubocop:disable Metrics/CyclomaticComplexity
    case weekday
    when 'monday'    then date.monday?
    when 'tuesday'   then date.tuesday?
    when 'wednesday' then date.wednesday?
    when 'thursday'  then date.thursday?
    when 'friday'    then date.friday?
    when 'saturday'  then date.saturday?
    when 'sunday'    then date.sunday?
    end
  end
end

The key to solving this challenge is to factor out the most complex parts into
helper methods and data structures. In particular:

    We may need to use the number of days in the month repeatedly, so we
    perform that calculation just once in the body of the constructor. This
    uses the somewhat tricky and poorly documented feature of the 
    Date constructor - if you pass a negative number for the day of month,
    it calculates the date relative to the end of the month. So, passing a
    value of -1 determines the end of the month, which we can use to determine
    the number of days in the month.

    We use a hash (SCHEDULE_START_DAY) and a short helper method
    (#first_day_to_search) to determine the first possible day of the month
    on which a meetup can occur. The hash does the bulk of the work: if we're
    looking for, say, the third Tuesday of the month, we use the hash to
    determine that the 3rd Tuesday can't possibly occur before the 15th of
    the month. The slightly trickier part is dealing with the last week of
    the month. In this case, we need to subtract 6 from the number of days
    in the month to find the first day to check.

    We also use a helper method, #day_of_week_is?, to check whether a date
    falls on the indicated day of week.

Our solution uses Enumerable#find to perform the search for the matching
date. Normally, find returns the value of the first item it finds in the
collection (a range in this case). However, if you use break with an argument,
it returns that argument instead. That allows us to return the calculated date
rather than just the day of the month.
=end

=begin
CONCEPT
- Date class is in the standard library. Unlike core libraries, which can 
  be used immediately, standard library comes pre-installed but can only
  be used if we require the class first first, in this case: require 'date'
  
- Date.civil(year, month, -1).day will return the correct number of days
  in that specific year and month (including february in leap years)
  
- Range object has the Enumerable module which has #detect, an alias for #find
  which returns the first element whose block return value is truthy. 
  If no such element is found, calls if_none_proc and returns its return value.
=end