=begin

1) What will the following code print? Why? Don't run it until you've attempted to answer.

def meal
  return 'Breakfast'
end

puts meal

=end

# It will print "Breakfast"


=begin

2) What will the following code print? Why? Don't run it until you've attempted to answer.

def meal
  'Evening'
end

puts meal

=end

# It will print "Evening". Without return, the last statement of a method will be the return value.


=begin

3) What will the following code print? Why? Don't run it until you've attempted to answer.

def meal
  return 'Breakfast'
  'Dinner'
end

puts meal

=end

# "Breakfast" will be printed. Once the return statement executes, the method end and 'Dinner' will not be evaluated or returned.


=begin

4) What will the following code print? Why? Don't run it until you've attempted to answer.

def meal
  puts 'Dinner'
  return 'Breakfast'
end

puts meal

=end

# 'Dinner'
# 'Breakfast'


=begin

5) What will the following code print? Why? Don't run it until you've attempted to answer.

def meal
  'Dinner'
  puts 'Dinner'
end

p meal

=end

# 'Dinner' # printed in method meal by puts command.
# 'nil' # returns by method meal and printed by p


=begin

6) What will the following code print? Why? Don't run it until you've attempted to answer.

def meal
  return 'Breakfast'
  'Dinner'
  puts 'Dinner'
end

puts meal

=end

# "Breakfast". The return statement meant that anything after that statement is not processed. 


=begin

7) What will the following code print? Why? Don't run it until you've attempted to answer.

def count_sheep
  5.times do |sheep|
    puts sheep
  end
end

puts count_sheep

=end

# 0   0-4 are printed in the times loop
# 1
# 2
# 3
# 4
# 5. The last number returns by the times method is 5 which is the return value from count_sheep.


=begin

8) What will the following code print? Why? Don't run it until you've attempted to answer.

def count_sheep
  5.times do |sheep|
    puts sheep
  end
  10
end

puts count_sheep

=end

# 0
# 1
# 2
# 3
# 4     # 0-4 printed within times loop
# 10    # returned by count_sheep


=begin

9) What will the following code print? Why? Don't run it until you've attempted to answer.

def count_sheep
  5.times do |sheep|
    puts sheep
    if sheep >= 2
      return
    end
  end
end

p count_sheep

=end

# 0
# 1
# 2     # printed in the count_sheep method
# nil   # returned by the return statement in count_sheep


=begin

10) What will the following code print? Why? Don't run it until you've attempted to answer.

def tricky_number
  if true
    number = 1
  else
    2
  end
end

puts tricky_number

=end

# 1. the method returns the last statement which is number = 1 (return 1)

