=begin

1) You come across the following code. What errors does it raise for the 
given examples and what exactly do the error messages mean?

def find_first_nonzero_among(numbers)
  numbers.each do |n|
    return n if n.nonzero?
  end
end

# Examples

find_first_nonzero_among(0, 0, 1, 0, 2, 0)  
find_first_nonzero_among(1)

=end

# ANSWER:
# Argument Error for the first example. Wrong number 
# of arguments, given 6, expecting 1. To solve this,
# we have to either pass the argument as a single
# literal array in the method call, or we modify
# the method definition to indicate the parameter is 
# a list using the *. 

# Solution 1 change the method definition
# def find_first_nonzero_among(*numbers)
#   numbers.each do |n|
#     return n if n.nonzero?
#   end
# end

# Solution 2: Change the method invocation
# find_first_nonzero_among([0, 0, 1, 0, 2, 0])
# find_first_nonzero_among([1])

# For second example, we will get a NoMethodError
# Undefined method for Integer.


=begin

2) Our predict_weather method should output a message indicating whether 
a sunny or cloudy day lies ahead. However, the output is the same every 
time the method is invoked. Why? Fix the code so that it behaves as 
expected.

def predict_weather
  sunshine = ['true', 'false'].sample

  if sunshine
    puts "Today's weather will be sunny!"
  else
    puts "Today's weather will be cloudy!"
  end
end

=end

# ANSWER:
# sunshine variable was given a string
# rather than boolean, which always gives a truthy value

def predict_weather
  sunshine = [true, false].sample

  if sunshine
    puts "Today's weather will be sunny!"
  else
    puts "Today's weather will be cloudy!"
  end
end


=begin

3) When the user inputs 10, we expect the program to print The result is 50!, 
but that's not the output we see. Why not?

def multiply_by_five(n)
  n * 5
end

puts "Hello! Which number would you like to multiply by 5?"
number = gets.chomp

puts "The result is #{multiply_by_five(number)}!"

=end

# ANSWER:
# number is assigned a string by gets (get string) method. Hence
# we will get a string rather than integer multiplication. 
# To solve this, we need to convert number to an integer/float 
# using .to_i/.to_f before passing to the method multiply_by_five.


=begin 

4) Magdalena has just adopted a new pet! She wants to add her new dog, 
Bowser, to the pets hash. After doing so, she realizes that her dogs 
Sparky and Fido have been mistakenly removed. Help Magdalena fix her 
code so that all three of her dogs' names will be associated with the 
key :dog in the pets hash.

pets = { cat: 'fluffy', dog: ['sparky', 'fido'], fish: 'oscar' }

pets[:dog] = 'bowser'

p pets #=> {:cat=>"fluffy", :dog=>"bowser", :fish=>"oscar"}

=end

pets = { cat: 'fluffy', dog: ['sparky', 'fido'], fish: 'oscar' }

pets[:dog].push('bowser')

p pets #=> {:cat=>"fluffy", :dog=>"bowser", :fish=>"oscar"}


=begin

5) We want to iterate through the numbers array and return a new array 
containing only the even numbers. However, our code isn't producing 
the expected output. Why not? How can we change it to produce the 
expected result?

numbers = [5, 2, 9, 6, 3, 1, 8]

even_numbers = numbers.map do |n|
  n if n.even?
end

p even_numbers # expected output: [2, 6, 8]

=end


# ANSWER:
# map apply the block to every element and capture its return 
# value.
# n if n.even? evaluates to n for even numbers and nil
# for odd numbers. Hence even_numbers will contain nil 
# objects unintentionally. To fix that, we use select,
# which only includes items that evaluate through in the block


numbers = [5, 2, 9, 6, 3, 1, 8]

even_numbers = numbers.select do |n|
  n.even? 
end

p even_numbers # expected output: [2, 6, 8]


=begin

6) You want to have a small script delivering motivational quotes, 
but with the following code you run into a very common error message: 
no implicit conversion of nil into String (TypeError). What is the
problem and how can you fix it?

def get_quote(person)
  if person == 'Yoda'
    'Do. Or do not. There is no try.'
  end

  if person == 'Confucius'
    'I hear and I forget. I see and I remember. I do and I understand.'
  end

  if person == 'Einstein'
    'Do not worry about your difficulties in Mathematics. I can assure you mine are still greater.'
  end
end

puts 'Confucius says:'
puts '"' + get_quote('Confucius') + '"'

=end


# ANSWER: get_quote method returns nil even though the string supplied
# matches the second if statement. However, that was not the final expression
# in the method. The last expression return a nil, which does not have a + method
# for string concatenation. To solve this, we change the multiple if to an if, elsif
# construct so that it returns immediately once a match is found. Alternatively,
# we get add return keyword in every if statment.

def get_quote(person)
  if person == 'Yoda'
    'Do. Or do not. There is no try.'

  elsif person == 'Confucius'
    'I hear and I forget. I see and I remember. I do and I understand.'

  elsif person == 'Einstein'
    'Do not worry about your difficulties in Mathematics. I can assure you mine are still greater.'
  end
end

puts 'Confucius says:'
puts '"' + get_quote('Confucius') + '"'


=begin

7) Time for a check of your financial situation.

The output of the code below tells you that you have around $70. However, you expected 
your bank account to have about $238. What did we do wrong?

# Financially, you started the year with a clean slate.

balance = 0

# Here's what you earned and spent during the first three months.

january = {
  income: [ 1200, 75 ],
  expenses: [ 650, 140, 33.2, 100, 26.9, 78 ]
}

february = {
  income: [ 1200 ],
  expenses: [ 650, 140, 320, 46.7, 122.5 ]
}

march = {
  income: [ 1200, 10, 75 ],
  expenses: [ 650, 140, 350, 12, 59.9, 2.5 ]
}

# Let's see how much you've got now...

def calculate_balance(month)
  plus  = month[:income].sum
  minus = month[:expenses].sum

  plus - minus
end

[january, february, march].each do |month|
  balance = calculate_balance(month)
end

puts balance

Note: This above program requires Ruby 2.4.0 or higher since the 
#sum method wasn't introduced to Ruby until version 2.4.0. If you 
must use an older version of Ruby, replace the #calculate_balance 
method with the following code:

def calculate_balance(month)
  plus  = month[:income].reduce(&:+)
  minus = month[:expenses].reduce(&:+)

  plus - minus
end

=end

# ANSWER: Original code only calculate the balance from the latest 
# month i.e. March. What we want is the cumulative balance from
# Jan to March. To do that, we need to accumulative each month's 
# balance using balance += calculate_balance(month) in the block.

balance = 0

# Here's what you earned and spent during the first three months.

january = {
  income: [ 1200, 75 ],
  expenses: [ 650, 140, 33.2, 100, 26.9, 78 ]
}

february = {
  income: [ 1200 ],
  expenses: [ 650, 140, 320, 46.7, 122.5 ]
}

march = {
  income: [ 1200, 10, 75 ],
  expenses: [ 650, 140, 350, 12, 59.9, 2.5 ]
}

# Let's see how much you've got now...

def calculate_balance(month)
  plus  = month[:income].sum
  minus = month[:expenses].sum

  plus - minus
end

[january, february, march].each do |month|
  balance += calculate_balance(month)
end

puts balance


=begin

8) The following code throws an error. Find out what is wrong 
and think about how you would fix it.

colors = ['red', 'yellow', 'purple', 'green', 'dark blue', 'turquoise', 'silver', 'black']
things = ['pen', 'mouse pad', 'coffee mug', 'sofa', 'surf board', 'training mat', 'notebook']

colors.shuffle!
things.shuffle!

i = 0
loop do
  break if i > colors.length

  if i == 0
    puts 'I have a ' + colors[i] + ' ' + things[i] + '.'
  else
    puts 'And a ' + colors[i] + ' ' + things[i] + '.'
  end

  i += 1
end

=end


# ANSWER: There are two problems with the original code. First,
# the conditional for the break clause meant that we will only exit the loop when i, 
# which serves as the index for both colors and things arrays is greater than the 
# color. Since array index starts from 0 to length-1, we will attempt to access 
# array[length] which will return nil. Secondly, colors and things are not of equal 
# length, with things shorter by 1. To solve the problem, we need to choose the shorter
# of the two arrays, and index up till its length -1 


colors = ['red', 'yellow', 'purple', 'green', 'dark blue', 'turquoise', 'silver', 'black']
things = ['pen', 'mouse pad', 'coffee mug', 'sofa', 'surf board', 'training mat', 'notebook']

colors.shuffle!
things.shuffle!

min_length = colors.size > things.size ? things.size : colors.size 

i = 0
loop do
  break if i > min_length - 1

  if i == 0
    puts 'I have a ' + colors[i] + ' ' + things[i] + '.'
  else
    puts 'And a ' + colors[i] + ' ' + things[i] + '.'
  end

  i += 1
end


=begin

9) Given a String of digits, our digit_product method should return 
the product of all digits in the String argument. You've been asked 
to implement this method without using reduce or inject.

When testing the method, you are surprised by a return value of 0. 
What's wrong with this code and how can you fix it?

def digit_product(str_num)
  digits = str_num.chars.map { |n| n.to_i }
  product = 0

  digits.each do |digit|
    product *= digit
  end

  product
end


p digit_product('12345')
# expected return value: 120
# actual return value: 0

=end

# NOTE: "123".chars returns ["1", "2", "3"]
# ANSWER: The product initial value is 0. Anything multiplied by 0 is 0.
# We need to start at 1.

def digit_product(str_num)
  digits = str_num.chars.map { |n| n.to_i }
  product = 1

  digits.each do |digit|
    product *= digit
  end

  product
end


p digit_product('12345')
# expected return value: 120
# actual return value: 0


=begin

10) We started writing an RPG game, but we already run into an error 
message. Find the problem and fix it.

# Each player starts with the same basic stats.

player = { strength: 10, dexterity: 10, charisma: 10, stamina: 10 }

# Then the player picks a character class and gets an upgrade accordingly.

character_classes = {
  warrior: { strength:  20 },
  thief:   { dexterity: 20 },
  scout:   { stamina:   20 },
  mage:    { charisma:  20 }
}

puts 'Please type your class (warrior, thief, scout, mage):'
input = gets.chomp.downcase

player.merge(character_classes[input])

puts 'Your character stats:'
puts player

=end

# ANSWER: The hash keys are symbol while input is a string
# Need to convert string to symbol. Merge returns a new array
# Need to use merge! to retain the updates.

# Each player starts with the same basic stats.

player = { strength: 10, dexterity: 10, charisma: 10, stamina: 10 }

# Then the player picks a character class and gets an upgrade accordingly.

character_classes = {
  warrior: { strength:  20 },
  thief:   { dexterity: 20 },
  scout:   { stamina:   20 },
  mage:    { charisma:  20 }
}

puts 'Please type your class (warrior, thief, scout, mage):'
input = gets.chomp.downcase.to_sym

player.merge!(character_classes[input])

puts 'Your character stats:'
puts player
