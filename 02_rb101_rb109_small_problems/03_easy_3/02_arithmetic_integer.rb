=begin

Arithmetic Integer

Write a program that prompts the user for two positive integers, and then
prints the results of the following operations on those two numbers:
addition, subtraction, product, quotient, remainder, and power. 
Do not worry about validating the input.

Example

==> Enter the first number:
23
==> Enter the second number:
17
==> 23 + 17 = 40
==> 23 - 17 = 6
==> 23 * 17 = 391
==> 23 / 17 = 1
==> 23 % 17 = 6
==> 23 ** 17 = 141050039560662968926103

=end

def display_result(op, first_number, second_number)
  result = case op
           when '+' then first_number + second_number
           when '-' then first_number - second_number
           when '*' then first_number * second_number
           when '/' then first_number / second_number
           when '%' then first_number % second_number
           when '**' then first_number ** second_number
           end
    
  puts "==> #{first_number} #{op} #{second_number} = #{result}"
end

puts "==> Enter the first number:"
first_number = gets.chomp.to_i
puts "==> Enter the second number:"
second_number = gets.chomp.to_i

display_result('+', first_number, second_number)
display_result('-', first_number, second_number)
display_result('*', first_number, second_number)
display_result('/', first_number, second_number)
display_result('%', first_number, second_number)
display_result('**', first_number, second_number)


=begin

Solution

def prompt(message)
  puts "==> #{message}"
end

prompt("Enter the first number:")
first_number = gets.chomp.to_i
prompt("Enter the second number:")
second_number = gets.chomp.to_i

prompt("#{first_number} + #{second_number} = #{first_number + second_number}")
prompt("#{first_number} - #{second_number} = #{first_number - second_number}")
prompt("#{first_number} * #{second_number} = #{first_number * second_number}")
prompt("#{first_number} / #{second_number} = #{first_number / second_number}")
prompt("#{first_number} % #{second_number} = #{first_number % second_number}")
prompt("#{first_number} ** #{second_number} = #{first_number**second_number}")

Discussion

There are some edge cases to consider in this exercise. We have to be careful
of not having a second number that is zero. What if we wanted to use floats
instead of integers? How does this change this problem?

If using floats, we have to be mindful of precision of answer

=end