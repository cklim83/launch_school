=begin

Optional Blocks

Write a method that takes an optional block. If the block is specified,
the method should execute it, and return the value returned by the block.
If no block is specified, the method should simply return the String
'Does not compute.'.

Examples:

compute { 5 + 3 } == 8
compute { 'a' + 'b' } == 'ab'
compute == 'Does not compute.'
=end


=begin
Problem
- inputs: compute method takes no arguments but may supply a block. Block if given also take no arguments.
- outputs: Return the evaluated value of the block or 'Does not compute.' if no block given

Examples
- See above

Algorithm
- Check if block is given. If yes, yield to block and return the value returned by block. 
  Else return 'Does not compute.'. Ternary operator suit the requirements
=end

def compute
  block_given? ? yield : 'Does not compute.'
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'


=begin
Solution

def compute
  return 'Does not compute.' unless block_given?
  yield
end

Discussion

The Kernel#block_given? method can be used to determine if a block has been
passed to a method, even if there is no mention of a block in the method
arguments. We use it here to detect when we should return 'Does not compute.'
, and when we should return the value yielded by the block.
Further Exploration

Modify the compute method so it takes a single argument and yields that
argument to the block. Provide at least 3 examples of calling this new
version of compute, including a no-block call.
=end


=begin
CONCEPT
- Use Kernel#block_given? as a conditional guard to make block optional
  to a method
=end