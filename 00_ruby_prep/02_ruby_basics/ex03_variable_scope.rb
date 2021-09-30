=begin

1) What will the following code print and why? Don't run it until 
you have tried to answer.

a = 7

def my_value(b)
  b += 10
end

my_value(a)
puts a

=end

# ANSWER: 7. No method will alter a number.


=begin

2) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = 7

def my_value(a)
  a += 10
end

my_value(a)
puts a

=end

# ANSWER: 7. Numbers are immutable. my_value does not alter 
# local variable a.


=begin

3) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = 7

def my_value(b)
  a = b
end

my_value(a + 5)
puts a

=end

# ANSWER: 7. Local variable a is not modified by method my_value.


=begin

4) What will the following code print, and why? Don't run the code 
until you have tried to answer..

a = "Xyzzy"

def my_value(b)
  b[2] = '-'
end

my_value(a)
puts a

=end

# ANWER: Xy-zy. local variable is pointing to a string, which
# is modified by a mutating method []= within my_value.


=begin

5) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = "Xyzzy"

def my_value(b)
  b = 'yzzyX'
end

my_value(a)
puts a

=end

# ANSWER: Xyzzy. my value is performing a reassignment operation 
# which does not mutate the string pointed by a.


=begin

6) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = 7

def my_value(b)
  b = a + a
end

my_value(a)
puts a

=end

# ANSWER: NameError. Underdefined local variable or method a. local 
# variable a is not accessible within my_value.


=begin

7) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = 7
array = [1, 2, 3]

array.each do |element|
  a = element
end

puts a

=end

# ANSWER: 3. local variable a defined before a block can be accessed 
# by the block. Within the block, a iteratively reassigned the value 
# in the array, with the final reassignment giving it a value of 3.


=begin

8) What will the following code print, and why? Don't run the code 
until you have tried to answer.

array = [1, 2, 3]

array.each do |element|
  a = element
end

puts a

=end

# ANSWER: NameError undefined local variable or method 'a' for main. 
# a is first defined within the block and is not available outside of it.


=begin

9) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = 7
array = [1, 2, 3]

array.each do |a|
  a += 1
end

puts a

=end

# ANSWER: 7. the local variable "a" within the block shadows
# the local variable defined below. Hence the each method does not
# modify the local variable a defined before it.


=begin

10) What will the following code print, and why? Don't run the code 
until you have tried to answer.

a = 7
array = [1, 2, 3]

def my_value(ary)
  ary.each do |b|
    a += b
  end
end

my_value(array)
puts a

=end

# ANSWER: NameError undefined local variable or method a in my_value. local
# variable a is not accessible within the method my_value.