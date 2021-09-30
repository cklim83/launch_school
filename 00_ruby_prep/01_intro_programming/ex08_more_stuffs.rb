=begin

1) Write a program that checks if the sequence of characters "lab" exists 
in the following strings. If it does exist, print out the word.

    "laboratory"
    "experiment"
    "Pans Labyrinth"
    "elaborate"
    "polar bear"

=end

def contains_lab(phrase)
  if /lab/.match(phrase)
    puts phrase
  else
    puts "#{phrase} does not contain lab!"
  end
end

  
strings = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]
for string in strings do 
  contains_lab(string)
end


=begin

2) What will the following program print to the screen? What will it return?

def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }

=end

# My Answer: It will not print anything since block is not called with .call method. Execute will return nil
# Correct Answer: Nothing is printed to the screen because the block is never activated with the .call method. The method returns a Proc object.

def execute(&block)
  block
end

p execute { puts "Hello from inside the execute method!" }


=begin

3) What is exception handling and what problem does it solve?
My Answer: Exception handling allows programs to continue functioning even when it encounters errors.

Correct Answer: Exception handling is a structure used to handle the possibility of an error occurring in a program. 
It is a way of handling the error by changing the flow of control without exiting the program entirely.

=end


=begin

4) Modify the code in exercise 2 to make the block execute properly.

=end

def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }


=begin

5) Why does the following code...

def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

Give us the following error when we run it?
block.rb1:in `execute': wrong number of arguments (0 for 1) (ArgumentError)
from test.rb:5:in `<main>'

=end

# My Answer: The execute method is expecting a normal variable since it doesnt have an ampersand but instead we supply a block. 

# Given Answer: The method parameter block is missing the ampersand sign & that allows a block to be passed as a parameter.