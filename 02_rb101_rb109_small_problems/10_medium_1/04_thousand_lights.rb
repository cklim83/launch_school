=begin

1000 Lights

You have a bank of switches before you, numbered from 1 to n. Each switch
is connected to exactly one light that is initially off. You walk down the
row of switches and toggle every one of them. You go back to the beginning,
and on this second pass, you toggle switches 2, 4, 6, and so on. On the
third pass, you go back again to the beginning and toggle switches 3, 6, 9,
and so on. You repeat this process and keep going until you have been
through n repetitions.

Write a method that takes one argument, the total number of switches, and
returns an Array that identifies which lights are on after n repetitions.

Example with n = 5 lights:

    round 1: every light is turned on
    round 2: lights 2 and 4 are now off; 1, 3, 5 are on
    round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
    round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
    round 5: lights 2, 3, and 5 are now off; 1 and 4 are on

The result is that 2 lights are left on, lights 1 and 4. The return value
is [1, 4].

With 10 lights, 3 lights are left on: lights 1, 4, and 9. The return value
is [1, 4, 9].
=end

=begin
Problem
- input: an integer n representing the number of switches
- output: an array containing the switches whose connected lights are left on

Examples
- requirements:
  - assume n must be positive

Data Structure
- input: a positive integer
- output: an array whose lights are on

Algorithm
1. set two arrays:
  on = [], off = [1, 2, .., n] 
2. set curr_pass = 1
3. while curr_pass <=  n
    to_off = on.select numbers which are divisible by curr_pass
          on = on.delete(to_off) | to_on # wrong syntas, return boolean instead
          off = off.delete(to_on) | to_off
    to_on = off.select numbers which are divisible by curr_pass
    on = delete elements in to_off and add elements from to_on
    off = delete elements in to_on and add elements from to_off
    increment curr pass
  end
4. return on
=end

def remove!(list, lights)
  lights.each do |light|
    list.delete(light)
  end
end

def lights_on(n)
  on = []
  off = (1..n).to_a
  curr_pass = 1
  
  while curr_pass <= n
    to_off = on.select { |num| num % curr_pass == 0 }
    to_on = off.select { |num| num % curr_pass == 0 }

    # update lights that are on
    remove!(on, to_off)
    on = on + to_on
      
    # update lights that are off
    remove!(off, to_on)
    off = off + to_off
  
    curr_pass += 1
  end
  
  on
end

p lights_on(5) == [1, 4]
p lights_on(10) == [1, 4, 9]
p lights_on(1000) == [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256,
                      289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900,
                      961]

=begin
Solution

# initialize the lights hash
def initialize_lights(number_of_lights)
  lights = Hash.new
  1.upto(number_of_lights) { |number| lights[number] = "off" }
  lights
end

# return list of light numbers that are on
def on_lights(lights)
  lights.select { |_position, state| state == "on" }.keys
end

# toggle every nth light in lights hash
def toggle_every_nth_light(lights, nth)
  lights.each do |position, state|
    if position % nth == 0
      lights[position] = (state == "off") ? "on" : "off"
    end
  end
end

# Run entire program for number of lights
def toggle_lights(number_of_lights)
  lights = initialize_lights(number_of_lights)
  1.upto(lights.size) do |iteration_number|
    toggle_every_nth_light(lights, iteration_number)
  end

  on_lights(lights)
end

p toggle_lights(1000)

Discussion

In this exercise, we use a Hash to represent our lights. A single light is
represented as a key-value pair within the hash. The key will be the position
that light has out of the 1000 lights; the first light is position 1, the
last is 1000. The value of each light is either "on" or "off" to represent
the state of that light.

We start by calling toggle_lights with an argument (the number of lights) of
1000.

toggle_lights immediately calls initialize_lights, which creates and returns
a Hash that represents all lights with a current state of off. toggle_lights
subsequently uses the 1.upto(lights.size) method call to iterate over the
lights as many times as needed (1000 based on our initial value). It uses
toggl_every_nth_light to toggle first every light, then every other light,
then every 3rd light, and so on, until we have iterated over all of the
lights 1000 times.

Finally, we call on_lights to select the lights that are still on. We use
Hash#select, which returns a new Hash that contains only the on lights,
and then, we chain Hash#keys method which returns an array with only the
keys of the Hash.

The definition of on_lights uses _position as a parameter name since we
don't use the parameter, but want to show what it represents. Using an
underscore at the beginning of a parameter name is a common convention
to show that a parameter isn't used.

Note that we don't use the value 1000 internally in most of our methods.
Instead, we use lights.size. This lets us easily reuse the code for any
number of lights.

Our final answer ends up being:

p on_lights(lights)

Output:

[1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256,
289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900,
961]

Further Exploration

There are a few interesting points about this exercise that we can
explore:

    Do you notice the pattern in our answer? Every light that is on
    is a perfect square. Why is that?

    What are some alternatives for solving this exercise? What if
    we used an Array to represent our 1000 lights instead of a Hash,
    how would that change our code?

    We could have a method that replicates the output from the
    description of this problem (i.e. "lights 2, 3, and 5 are now off;
    1 and 4 are on.") How would we go about writing that code?
=end

=begin
TO REVIEW
- My misconceptions
  on = on.delete(to_off) | to_on # wrong syntas, return boolean instead
  [].delete([]) returns nil, when | with [1, 2] => true, a boolean
  I thought | operator allows me to perform union
  
 [1, 3] | [3, 5]
 => [1, 3, 5] 
 [1, 3, 3] | [3, 5]                                                                                                                               
 => [1, 3, 5] 
 [1, 3, 5] | [3, 5]                                                                                                                               
 => [1, 3, 5] 
 [1, 3, 5] | [5, 3, 1]                                                                                                                           
 => [1, 3, 5] 
 nil | [1, 3]
 => true

- learn #upto, #delete, #difference and #|, #reject  

- perform toggling of states using hash or two arrays

- [1, 2, 3] + [4, 5, 6] => new array [1, 2, 3, 4, 5, 6]

- Learn how to delete more than 1 item value from an array
  e.g. remove 2 and 5 from [1, 2, 4, 5, 7, 8]
  
  list.reject! {|item| item.name =~ /cat|dog|rat/i }

=end