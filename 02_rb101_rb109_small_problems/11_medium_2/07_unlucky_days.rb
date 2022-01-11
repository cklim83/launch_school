=begin

Unlucky Days

Write a method that returns the number of Friday the 13ths in the year
given by an argument. You may assume that the year is greater than 1752
(when the United Kingdom adopted the modern Gregorian Calendar) and that
it will remain in use for the foreseeable future.

Examples:

friday_13th(2015) == 3
friday_13th(1986) == 1
friday_13th(2019) == 2
=end

=begin
Problem
- input: an integer representing year after 1752, when Gregorian Calendar was adopted
- output: integer representing number of Friday the 13th in that year

Examples
- There are 3, 1, and 2 Friday the 13th in year 2015, 1986 and 2019 respectively
- input > 1752 and output is >= 0

Data Structure
- input: integer
- output: integer
- intermediary: constant array representing months in a year

Algorithm
1. Set MONTHS = (1..12).to_a, unlucky_date_counter = 0
2. Iterate month in MONTHS with a block
  a. within it, create a date with input year, month, date=13
  b. Increment unlucky_date_counter if date is a friday
3. return unlucky_date_counter
=end

require 'date'

MONTHS = (1..12).to_a

def friday_13th(year)
  unlucky_date_counter = 0
  MONTHS.each do |month|
    unlucky_date_counter += 1 if Date.new(year, month, 13).friday?
  end
  
  unlucky_date_counter
end

p friday_13th(2015) == 3
p friday_13th(1986) == 1
p friday_13th(2019) == 2


=begin
TO REVIEW
- Date class
  - Date.new(year, month, day)
  - #friday?
  - other date functions
  - require 'date' module
=end