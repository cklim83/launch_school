=begin

What Century is That?

Write a method that takes a year as input and returns the century. The
return value should be a string that begins with the century number, and
ends with st, nd, rd, or th as appropriate for that number.

New centuries begin in years that end with 01. So, the years 1901-2000
comprise the 20th century.

Examples:

century(2000) == '20th'
century(2001) == '21st'
century(1965) == '20th'
century(256) == '3rd'
century(5) == '1st'
century(10103) == '102nd'
century(1052) == '11th'
century(1127) == '12th'
century(11201) == '113th'

=end

=begin

Problem
- Input: Integer representing year
- Output: String representing century that year is in

Examples
- See above. 
- Observations: 
  - Non zero remainder = divisor + 1 century 
  - Zero remainder = divisor century
    - 2000.divmod 100 => (20, 0) = 20th century
    - 10103.divmod 100 => (101, 3) = 102th century
    
  https://english.lingolia.com/en/vocabulary/numbers-dates-time/ordinal-numbers  
  - 1: st suffix unless last 2 digits of century are 11 i.e. eleventh
  - 2: nd suffix unless last 2 digits of century are 12
  - 3: rd suffix unless last 2 digits of century are 13
  - all other numbers use th suffix
  
Data Structure
- Input: Integer (non-negative)
- Output: String
- Intermediary: Likely integer and string

Algorithm
1) Divide the input year by 100 to get divisor and remainder
2) If remainder is 0, century = divisor, else century = divisor + 1
3) Convert century to string, then get suffix according to below rules
- If last digit is '1', suffix = 'st' unless second last digit is '1'
- If last digit is '2', suffix = 'nd' unless second last digit is '1'
- If last digit is '3', suffix = 'rd' unless second last digit is '1' 

=end
def suffix(century_str)
  last_digit = century_str[-1]
  second_last_digit = century_str[-2]
  
  if last_digit == '1' && second_last_digit != '1'
    'st'
  elsif last_digit == '2' && second_last_digit != '1'
    'nd'
  elsif last_digit == '3' && second_last_digit != '1'
    'rd'
  else
    'th'
  end
end

def century(year)
  divisor, remainder = year.divmod 100
  century_year = (remainder == 0) ? divisor : divisor + 1
  century_str = century_year.to_s
  century_str + suffix(century_str)
end
  
p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'


=begin

Solution

def century(year)
  century = year / 100 + 1
  century -= 1 if year % 100 == 0
  century.to_s + century_suffix(century)
end

def century_suffix(century)
  return 'th' if [11, 12, 13].include?(century % 100)
  last_digit = century % 10

  case last_digit
  when 1 then 'st'
  when 2 then 'nd'
  when 3 then 'rd'
  else 'th'
  end
end

Discussion

First, notice a pattern about a century. It is equal to the current year
divided by 100 plus 1. The exception to this is if the year is some multiple
of 100. In that case, the century is the current year divided by 100.

Next we need to understand which suffix to append for our century, the
options being: 'th', 'nd', 'rd', 'st'. We decide which one to use by
checking the last digit of the century. Though, before we do that, we
do need to do one extra check. If the century's value mod 100 ends in
either 11, 12, or 13, then we should return 'th'. Any other time, we
can return a suffix determined by our case statement and the value of
century % 10.

Finally, we combine the string representation of the century with the
correct suffix, and we have our answer.

=end