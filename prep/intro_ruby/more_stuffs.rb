=begin

Write a program that checks if the sequence of characters "lab" exists in the following strings. If it does exist, print out the word.

    "laboratory"
    "experiment"
    "Pans Labyrinth"
    "elaborate"
    "polar bear"
=end

def print_if_exist(strings, pat)
  strings.each do |string|
    if /#{pat}/i =~ string   # i stands for case insensitive matching
      puts string
    else
      puts "#{string} does not contain #{pat}"
    end
  end
end

string_list = ['laboratory', 'experiment', 'Pans Labyrinth', 'elaborate', 'polar bear']

print_if_exist(string_list, 'lab')


=begin
What will the following program print to the screen? What will it return?

def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }

My Answer:
It will do nothing since we did not call the block. nil will be returned. 
Correction: Nil is only returned if call is invocated. This nil comes from puts.

Correct Answer:
Nothing is printed to the screen because the block is never activated with the .call method. The method returns a Proc object.

=end


=begin
What is exception handling and what problem does it solve?

My Answer:
Exception handling refers to catching and handling expected errors e.g. due to wrong inputs by user, in specific segments of code
so that the program can continue and not terminate prematurely

Given Answer:
Exception handling is a structure used to handle the possibility of an error occurring in a program. It is a way of handling the error
by changing the flow of control without exiting the program entirely.

=end


=begin
Why does the following code...

1.  def execute(block)
2.    block.call
3.  end
4.
5.  execute { puts "Hello from inside the execute method!" }

Give us the following error when we run it?

block.rb1:in `execute': wrong number of arguments (0 for 1) (ArgumentError)
from test.rb:5:in `<main>'

My Answer:
&block is required for the method argument. The missing & caused the execute method to expect a parameter enclosed in () which is not supplied

Given Answer:
The method parameter block is missing the ampersand sign & that allows a block to be passed as a parameter

=end


