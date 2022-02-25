=begin
Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

What output does this code print? Fix this class so that
there are no surprises waiting in store for the unsuspecting
developer.
=end

=begin
My answer:
Fluffy
My name is FLUFFY
FLUFFY
Fluffy

Reason for this behavior is because puts fluffy invoke the
to_s method which mutates the instance variable in-place. To 
fix it, we need to ensure to_s does not mutate the instance
variable.

=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name




=begin
Solution

Output:

Fluffy
My name is FLUFFY.
FLUFFY
FLUFFY

Corrected Class:

class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

Discussion

The original version of #to_s uses String#upcase! which mutates its
argument in place. This causes @name to be modified, which in turn
causes name to be modified: this is because @name and name reference
the same object in memory.

Oh, and that to_s inside the initialize method? We need that for the
challenge under Further Exploration.

Further Exploration

What would happen in this case?

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

This code "works" because of that mysterious to_s call in Pet#initialize.
However, that doesn't explain why this code produces the result it does.
Can you?


REVIEW
- name.to_s in initialize returns self if caller is a string according 
  to documentation
- When we mutate @name, we also mutate name since @name is referencing 
  the same string object as name
=end


class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
     @name.upcase!
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin

Further Exploration

42
My name is 42
42
43

The 42.to_s returns a new string object '42' which is assigned to @name.
Hence @name and name are not pointing to different objects, the former
'42' and the latter 42. We then reassign name to 43. Calling to_s do
not mutate @name since the upcase version of '42' is still '42'.
=end