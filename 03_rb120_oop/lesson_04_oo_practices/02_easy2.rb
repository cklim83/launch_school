=begin
Question 1

You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

What is the result of executing the following code:

oracle = Oracle.new
oracle.predict_the_future

My answer:
It will return one of the strings below
- "You will eat a nice lunch"
- "You will take a nap soon"
- "You will stay at work late"

Solution

Each time you call, a string is returned which will be of the form
"You will <something>", where the something is one of the 3 phrases
defined in the array returned by the choices method. The specific
string will be chosen randomly.


CONCEPTS
- Create instance of a class
- Instance method invocation

=end


=begin
Question 2

We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future

My answer:
It will return "You will "  + one of "visit Vegas", "fly to Fiji" or "romp in Rome"
chosen at random. This happens because RoadTrip#choices have overridden Oracle#choices

Solution

Now the string returned will be of the form "You will <some trip>" where the trip is
taken from the choices defined by the choices method of RoadTrip.

Why does this happen? Doesn't the choices called in the implementation of Oracle's
predict_the_future look in the Oracle class for a choices method? The answer is that
since we're calling predict_the_future on an instance of RoadTrip, every time Ruby
tries to resolve a method name, it will start with the methods defined on the class
you are calling. So even though the call to choices happens in a method defined in
Oracle, Ruby will first look for a definition of choices in RoadTrip before falling
back to Oracle if it does not find choices defined in RoadTrip. To see this in action,
change the name of the choices method in RoadTrip (call it chooses) and see what happens.


CONCEPTS
- Class Inheritance
- Method lookup path:
    - always start with caller class, even if we are invoking it from 
      parent method

TO REVIEW (VERY IMPORTANT)
- Even though the choices method is invoked within Oracle#predict_the_future, it is NOT
  Oracle#choices that will be invoked. Since the caller is a RoadTrip object, the Ruby
  method lookup path will ensure we will start the search for any method in RoadTrip 
  class first. Only when it is not found there does it look up its ancestors.

=end


=begin
Question 3

How do you find where Ruby will look for a method when that method is called?
How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

What is the lookup chain for Orange and HotSauce?

My answer:
Use the ancestor method on the class. `object.class.ancestor`

Lookup chain for Orange = [Orange, Taste, Object, Kernel, BasicObject]
Lookup chain for Hotsauce = [Hotsauce, Taste, Object, Kernel, BasicObject]


Solution
To get the ancestors of a particular class you can ask the class itself
and it will tell you directly if you call ancestors on it.

For example:

>> HotSauce.ancestors
=> [HotSauce, Taste, Object, Kernel, BasicObject]

The list of ancestor classes is also called a lookup chain, because Ruby
will look for a method starting in the first class in the chain (in this
case HotSauce) and eventually lookup BasicObject if the method is found
nowhere in the lookup chain.

If the method appears nowhere in the chain then Ruby will raise a
NoMethodError which will tell you a matching method can not be found
anywhere in the chain.

Keep in mind this is a class method and it will not work if you call
this method on an instance of a class (unless of course that instance
has a method called ancestors).


CONCEPTS
- Method lookup path
- Module inclusion in class
- ::Ancestors

TO REVIEW
- ancestors is a class method

=end


=begin
Question 4

What could you add to this class to simplify it and remove two methods from
the class definition while still maintaining the same functionality?

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

My answer:
class BeesWax
  attr_accessor :type
  
  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

Since the manually defined getter and setter for @type has no customisation,
we can use the attr_accessor method to generate them.


Solution
We can add attr_accessor to the top of the class. And it will give us the
ability to get and set the @type instance variable the same as we can do now.

This simplifies the class substantially and now the class would look like:

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{@type} type of Bees Wax"
  end
end

While this is much better, there is still something we can improve.

Currently, inside the describe_type method, we are referencing the @type variable
with the @ symbol, but this is not needed. As there is a method in the class which
replaces the need to access the instance variable directly we can change the
describe_type method to be:

def describe_type
  puts "I am a #{type} type of Bees Wax"
end

This is much cleaner, and it is standard practice to refer to instance variables
inside the class without @ if the getter method is available.


CONCEPTS
- attr_accessor
- use attribute accessors to access instance variables in instance method rather than direct access

=end


=begin
Question 5

There are a number of variables listed below. What are the different types
and how do you know which is which?

excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

My answer:
- Local variable, because it is not capitalized.
- Instance variable because it begins with @
- Class variable because it begins with @@


Solution
Here we have the following variables:

Local variable - excited_dog Instance variable - @excited_dog Class variable - @@excited_dog

We can tell which is which by how the variables are prefixed. Local variables
do not contain anything prefixed, while instance variables are prefixed with
the @ and class variables are prefixed with @@.


CONCEPTS
- Signature of local variable, instance variable, and class variable

=end


=begin
Question 6

If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

Which one of these is a class method (if any) and how do you know?
How would you call a class method?

My answer:
self.manufacturer is a class method since it has self. prefix
Television.manufacturer


Solution

Class methods in Ruby start with self so in this case the self.manufacturer
method is the class method.

You can call a class method by using the class name and then calling the
method. For example here it would be Television.manufacturer.


CONCEPTS
- class method definition and invocation

=end


=begin
Question 7

If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

Explain what the @@cats_count variable does and how it works.
What code would you need to write to test your theory?

My answer:
@@cats_count is a class variable used to track how many
Cat objects are created using ::new class method. It does 
this by incrementing the value of @@cats_count by 1 within
the initialize method, which is automatically called every time
we create a Cat instance using new

Cat.cats_count # => 0
meow = Cat.new("meow")
Cat.cats_count # => 1
cutey = Cat.new("cutey")
Cat.cats_count # => 2


Solution
The @@cats_count variable is here to keep track of how many cat instances
have been created. We can know this because of where in the code the number
incremented.

Every time we create a cat using Cat.new("tabby") we will be creating a new
instance of the class Cat. During the object creation process it will call
the initialize method and here is where we increment the value of the
@@cats_count variable.

To test your theory you could print the value of the @@cats_count variable
to the screen after it has been incremented, like this:

def initialize(type)
  @type = type
  @age  = 0
  @@cats_count += 1
  puts @@cats_count
end

If you did this when you created more cats you could verify that the value
was incremented.

>> Cat.new(‘tabby’)
1
=> #<Cat:0x007fe05a0aebe0 @type=“tabby”, @age=0>
>> Cat.new(‘russian blue’)
2
=> #<Cat:0x007fe05a0a74d0 @type=“russian blue”, @age=0>
>> Cat.new(‘shorthair’)
3
=> #<Cat:0x007fe05a0a2d40 @type=“shorthair”, @age=0>

CONCEPT
- Example use of class variables

=end


=begin
Question 8

If we have this class:

class Game
  def play
    "Start the game!"
  end
end

And another class:

class Bingo
  def rules_of_play
    #rules of play
  end
end

What can we add to the Bingo class to allow it to
inherit the play method from the Game class?

My answer:
class Bingo < Game


Solution
To tell Ruby that the Bingo class will inherit from the Game class we
need to put it after the class name when defining the Bingo class. An
example of this would look like:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

To test this code out we will need to create a new instance of the class
Bingo and then call the play method on that instance, as you can see below:

>> game_of_bingo = Bingo.new
=> #<Bingo:0x007f9d19b537c8>
>> game_of_bingo.play
=> "Start the game!"


CONCEPTS
- class inheritance of instance method
=end


=begin
Question 9

If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

What would happen if we added a play method to the Bingo class, keeping
in mind that there is already a method of this name in the Game class
that the Bingo class inherits from.

My answer:
Bingo#play will override Game#play everytime we invoke play instance
method on a Bingo object. This is due to method lookup hierarchy.


Solution
If we added a new method to the Bingo class as seen below, it will use that
method instead of looking up the chain and finding the Game class's method.
Because Ruby doesn't want to look all over the place, as soon as it finds a
method that matches it uses that - so in this case it is really first come
first served.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Eyes down"
  end
end


CONCEPTS
- Override parent instance method

=end


=begin
Question 10

What are the benefits of using Object Oriented Programming in Ruby?
Think of as many as you can.

My answer:
1) We can use class inheritance and modules to organise methods and
   practice DRY principles as much as possible. This also makes code
   maintenance easier as we do not need to modify all copies of a method
2) We can practice encapsulation where we can hide the internal
   representations of an object from user and only expose interfaces
   relevant to their use cases. Any implementation changes will not affect
   other codebases using these classes as long as the public interfaces 
   does change
3) We can make use of polymorphism which provide more flexibility since
   the code is scalable to new object types as long as they implement
   the required method signature


Solution

Because there are so many benefits to using OOP we will just summarize some of the major ones:

1. Creating objects allows programmers to think more abstractly about the code they are writing.
2. Objects are represented by nouns so are easier to conceptualize.
3. It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an application without duplication.
5. We can build applications faster as we can reuse pre-written code.
6. As the software becomes more complex this complexity can be more easily managed.


=end