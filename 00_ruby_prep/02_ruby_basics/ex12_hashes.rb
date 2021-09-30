=begin

1) Create a hash that contains the following data and assign it to a 
variable named car.

type 	color 	mileage
sedan 	blue 	80_000

=end

car = {
  type:     'sedan',
  color:    'blue',
  mileage:  80_000
}

p car


=begin

2) Using the code below, add the key :year and the value 2003 to car.

car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80_000
}

=end

car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80_000
}

car[:year] = 2003
p car


=begin

3) Using the following code, delete the key :mileage and its associated 
value from car.

car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80_000,
  year:    2003
}

=end

car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80_000,
  year:    2003
}

car.delete(:mileage)
p car


=begin

4) Using the following code, select the value 'blue' from car and 
print it with #puts.

car = {
  type:    'sedan',
  color:   'blue',
  year:    2003
}

=end

car = {
  type:    'sedan',
  color:   'blue',
  year:    2003
}

puts car[:color]


=begin

5) Use Hash#each to iterate over numbers and print each element's 
key/value pair.

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

Expected output:
A high number is 100.
A medium number is 50.
A low number is 10.

=end

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

numbers.each do |category, value|
  puts "A #{category} number is #{value}."
end


=begin

6) Use Enumerable#map to iterate over numbers and return an array 
containing each number divided by 2. Assign the returned array to 
a variable named half_numbers and print its value using #p.

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

Expected output:
[50, 25, 5]

=end

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

half_numbers = numbers.map { |key, value| value / 2 }
p half_numbers


=begin

7) Use Hash#select to iterate over numbers and return a hash 
containing only key-value pairs where the value is less than 25. 
Assign the returned hash to a variable named low_numbers and 
print its value using #p.

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

Expected output:
{:low=>10}

=end


numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select { |key, value| value < 25 }
p low_numbers


=begin

8) In the following code, numbers isn't mutated because #select isn't 
a destructive method. However, there is a destructive version of #select 
named #select!. Modify the code to use #select! instead of #select.

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select do |key, value|
                 value < 25
               end

p low_numbers
p numbers

Expected output:
{low: 10}
{low: 10}

=end

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select! do |key, value|
                 value < 25
               end

p low_numbers
p numbers


=begin

9) Create a nested hash using the following data.

Car
type 	color 	year
sedan 	blue 	2003

Truck
type 	color 	year
pickup 	red 	1998

=end

automobiles = {
  Car: {
    type:   'sedan',
    color:  'blue',
    year:   2003
  },
  
  Truck: {
    type:   'pickup',
    color:  'red',
    year:   1998
  }
}

p automobiles


=begin

10) Rewrite car as a nested array containing the same key-value pairs.

car = {
  type:  'sedan',
  color: 'blue',
  year:  2003
}

=end

car = [[type:, 'sedan'], [color: 'blue'], [year: 2003]]
p car
