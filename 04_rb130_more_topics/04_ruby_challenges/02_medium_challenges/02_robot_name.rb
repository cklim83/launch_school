# rubocop:disable all
=begin

Robot Name

Write a program that manages robot factory settings.

When robots come off the factory floor, they have no name. The first time you
boot them up, a random name is generated, such as RX837 or BC811.

Every once in a while, we need to reset a robot to its factory settings, which
means that their name gets wiped. The next time you ask, it will respond with
a new random name.

The names must be random; they should not follow a predictable sequence.
Random names means there is a risk of collisions. Your solution should not
allow the use of the same name twice when avoidable.
=end


=begin
Problem
- input: None
- ouput: A random robot name in the format /^[A-Z]{2}\d{3}$/

Examples
- A random name is generated on creation on upon reset.

Test Cases
- Robot class is required
- Constructor does not have any parameters
- a name attribute accessor
- a reset instance method to change the name attribute
- #name attribute accessor retrieves the attribute rather than generate a new 
  name since calling it twice on same object without reset returns same name
- name is of the format /^[A-Z]{2}\d{3}$/
- robot_name before and after reset should be different
- Names of different instance of Robot should mostly be different 
  (improbable collision)
- Same random seed still generate different name for different object

Data Structure
- input: NA
- output: a random string of format /^[A-Z]{2}\d{3}$/
- maybe a string or array to hold each character as they are generated

Algorithm
- Constructor
  - call generate_name helper method and assign result to @name

- reset
  - call generate_name helper method and assign result to @name
  
- generate_name helper method
  set name = ""
  2.times { sample character from within 'A'..'Z' and append to name }
  3.times { sample character from within '0'..'9' and append to name }
  return name
=end
# rubocop:enable all

class Robot
  attr_reader :name

  def initialize
    @name = generate_name
  end

  def reset
    @name = generate_name
  end

  private

  def generate_name
    name = ""
    2.times { name << ('A'..'Z').to_a[Random.new_seed % 26] }
    3.times { name << ('0'..'9').to_a[Random.new_seed % 10] }

    name
  end
end

# rubocop:disable all
=begin
PEDAC Solution

Understanding the Problem
  For our program, the details we need to keep in mind are as follows:

    Since robot names are created randomly without input from a user, our
    program doesn't need to expect any input argument. The name we later
    return will be a string.
    
    A robot's name is generated the first time it is booted up after being
    manufactured as well as the first time it is booted up after a factory
    reset.
    
    The randomly generated names seem to follow a pattern of 2 uppercase
    alphabetic characters followed by three digits.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create a
  Robot class. The class should have 2 methods as follows:

    a method named name that returns the robots randomly generated name
    (a string). The format of the name is 2 uppercase alphabet characters
    followed by three digits.
    
    a method named reset that restores the robot to factory functions. This
    means that any previously existing name for the robot is wiped and a new
    one must be generated.

  We may also want to create some helper methods to assist us, but those
  are optional.


Data Structures
  We know that we will be working with strings in order to generate and
  return a robot's name.

  The problem description stated that we should make an effort to avoid
  collisions of the randomly generated names for various robots. This
  suggests that we might also want to use a static or class-level collection
  such as an array in order to track random names that have already been
  assigned to instances of the Robot class.


Hints and Questions
  In the name method:

    If the current instance of Robot doesn't already have a saved name,
    generate one.
    
    If you have to generate a new name, make sure there are no collisions
    with existing robot names.



Algorithm

    Method: name
        If the robot already has a name assigned, return that name.
        If the robot does not yet have a name:
            Generate a random name (using helper function).
            
            Continue generating random names until the class-level collection
            being used to track names of existing robots does not include the
            newly generated name.
        Save the robot's new name.
        Save the name in the class-level collection used to track in-use names.
        Return the name.

    Method: reset

    Remove the current value of the robot's name from the class-level
    collection that tracks the in-use names of all existing robots.

    Remove the existing value of the robot's name from the object.
        A falsy placeholder value might be appropriate

    Helper Method to generate name
        Begin with an empty name string.
        Generate two random uppercase alphabetic characters and append them
        to the name string.
            A helper function might be useful for generating the random letters.
        
        Generate three random digits from 0-9 and append them to the name
        string.
            A helper function might be useful for generating the random digits.
        Return the name string.
        

Ruby Solution and Discussion

class Robot
  @@names = []

  def name
    return @name if @name
    @name = generate_name while @@names.include?(@name) || @name.nil?
    @@names << @name
    @name
  end

  def reset
    @@names.delete(@name)
    @name = nil
  end

  private

  def generate_name
    name = ''
    2.times { name << rand(65..90).chr }
    3.times { name << rand(0..9).to_s }
    name
  end
end

The Robot class has a class variable names, which is an array that holds all of
the currently taken names for instances of the Robot class.

The name method simply returns the robots name if one has already been
assigned. Otherwise, the helper method generate_name is repeatedly invoked
until a unique name (one that is not present in the names array) has been
assigned. The newly generated unique name is added to the static names array
and then returned from the method.

Our generate_name method concatenates two random alphabetic characters and
three random digits onto the name string and returns the resulting name. We
use rand to find a random character in the ranges we provide. For the letters,
we use their corresponding ASCII codes to choose a random number, then convert
that number to a letter using chr.

The reset method uses the built-in Array#delete method to delete the instance
of the current name from our list of used names. We do this so that the name
is free to be used by instances of Robot created in the future. We then reset
the current robot's name to nil.
=end


=begin
CONCEPTS (VERY IMPORTANT)
- To truly avoid collision, we cannot leave it to chance. Although using
  a large enough random number can reduce the odds, it is not fool-proof.

- The given solution uses a Class variable to track all names in use by 
  objects of that class so that newly generated names that match those in use
  are discarded and another name is randomly generated. 

- setting srand always ensure that the randomly generated number
  follows a reproducible sequence. So, setting srand, than using #rand or 
  #sample will always produce the same number sequence
  
  e.g.
  # Initialize srand, generate first set of random numbers
  srand 123456789987654321
  
  rand => 0.2174162730459992 
  rand => 0.539762062285717
  rand => 0.19457576983605063
  
  ('A'..'Z').to_a.sample => "E"
  ('A'..'Z').to_a.sample => "N"
  ('A'..'Z').to_a.sample => "I"
  
  # Reinitialize srand with SAME seed, generate second set of random numbers
  srand 123456789987654321
  
  rand => 0.2174162730459992
  rand => 0.539762062285717
  rand => 0.19457576983605063
  
  ('A'..'Z').to_a.sample => "E"
  ('A'..'Z').to_a.sample => "N"
  ('A'..'Z').to_a.sample => "I"
  
  There is no real randomness as the same sequence of random numbers will be
  produced since this process of using same seed is deterministic. 
  
  My solution was able to solve this as Random.new_seed generates a random 
  number each time that is not a deterministic sequence and is independent
  of the srand seed value.
  
  The reason the given solution works is because the class variable tracks the
  names already in-use, rejects the resultant same names and continue 
  generating brand new random numbers which results in new names.
  
  (Using generate_name in given solution)
  srand 123456789987654321
  
  generate_name => "JF087"  
  generate_name => "BE838"
  
  
  srand 123456789987654321
  
  generate_name => "JF087"  # rejected as in @@names
  generate_name => "BE838"  # rejected as in @@names
  generate_name => "DK933"  # New names that were not in @@names and hence accepted
  
=end