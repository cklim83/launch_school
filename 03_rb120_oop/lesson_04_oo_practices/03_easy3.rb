=begin
Question 1

If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

What happens in each of the following cases:

case 1:

hello = Hello.new
hello.hi

case 2:

hello = Hello.new
hello.bye

case 3:

hello = Hello.new
hello.greet

case 4:

hello = Hello.new
hello.greet("Goodbye")

case 5:

Hello.hi

My answer:
case 1: output "Hello", return nil
case 2: NameError, undefined method bye
case 3: Argument error, expecting 1 argument received 0
case 4: output "Goodbye", return nil
case 5: NameError, undefined method 'hi' for Hello:Class


Solution:
    case 1

    "Hello" is printed to the terminal.

    case 2

    An undefined method error occurs. Neither the Hello class
    nor its parent class Greeting have a bye method defined.

    case 3

    An ArgumentError reporting a wrong number of arguments is
    returned. The Hello class can access its parent class's greet
    method, but greet takes an argument which is not being
    supplied if we just call greet by itself.

    case 4

    "Goodbye" is printed to the terminal.

    case 5

    An undefined method hi is reported for the Hello class. This is
    because the hi method is defined for instances of the Hello class,
    rather than on the class itself. Since we are attempting to call
    hi on the Hello class rather than an instance of the class, Ruby
    cannot find the method on the class definition.
    
CONCEPTS
- Inheritance, instance method invocation, class vs instance method

TO REVIEW
- The error should be NoMethodError rather than NameError

=end


=begin
Question 2

In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

If we call Hello.hi we get an error message. How would you fix this?

My answer:
Option 1: Hello.new.hi
Option 2: Create a hi class method self.hi

Solution
You could define the hi method on the Hello class as follows:

class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

This is rather cumbersome. Note that we cannot simply call greet in the self.hi
method definition because the Greeting class itself only defines greet on its
instances, rather than on the Greeting class itself.

CONCEPT
- Cannot call an inherited instance method in a class method directly

TO REVIEW
- We cannot call an instance variable in a class method without first creating an instance of the required class
  
  For example we cannot call greet directly from within self.hi in Hello class as that
  is not invoking greet instance method from Greeting but rather invoking Hello.greet, a method 
  which is non-existance

2.6.3 :001 > class Greeting
2.6.3 :002?>     def greet(message)
2.6.3 :003?>         puts message
2.6.3 :004?>       end
2.6.3 :005?>   end
 => :greet 
2.6.3 :006 > class Hello < Greeting
2.6.3 :007?>   def hi
2.6.3 :008?>     greet("hello")
2.6.3 :009?>     end
2.6.3 :010?>   def self.hi
2.6.3 :011?>     greet("hello")
2.6.3 :012?>     end
2.6.3 :013?>   end
 => :hi 
2.6.3 :014 > Hello.hi
Traceback (most recent call last):
        5: from /home/ec2-user/.rvm/rubies/ruby-2.6.3/bin/irb:23:in `<main>'
        4: from /home/ec2-user/.rvm/rubies/ruby-2.6.3/bin/irb:23:in `load'
        3: from /home/ec2-user/.rvm/rubies/ruby-2.6.3/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        2: from (irb):14
        1: from (irb):11:in `hi'
NoMethodError (undefined method `greet' for Hello:Class)
2.6.3 :015 > 

- Similarly, we cannot define the body of self.hi to call hi as that is calling self.hi recursively
  rather than the hi instance method, resulting in a SystemStackError(stack level too deep)

2.6.3 :001 > class Greeting
2.6.3 :002?>     def greet(message)
2.6.3 :003?>         puts message
2.6.3 :004?>       end
2.6.3 :005?>   end
 => :greet 
2.6.3 :006 > class Hello < Greeting
2.6.3 :007?>   def hi
2.6.3 :008?>     greet("hello")
2.6.3 :009?>     end
2.6.3 :010?>   def self.hi
2.6.3 :011?>     hi
2.6.3 :012?>     end
2.6.3 :013?>   end
 => :hi 
2.6.3 :014 > Hello.hi
Traceback (most recent call last):
       16: from (irb):11:in `hi'
       15: from (irb):11:in `hi'
       14: from (irb):11:in `hi'
       13: from (irb):11:in `hi'
       12: from (irb):11:in `hi'
       11: from (irb):11:in `hi'
       10: from (irb):11:in `hi'
        9: from (irb):11:in `hi'
        8: from (irb):11:in `hi'
        7: from (irb):11:in `hi'
        6: from (irb):11:in `hi'
        5: from (irb):11:in `hi'
        4: from (irb):11:in `hi'
        3: from (irb):11:in `hi'
        2: from (irb):11:in `hi'
        1: from (irb):11:in `hi'
SystemStackError (stack level too deep)
2.6.3 :015 > 
=end


=begin
Question 3

When objects are created they are a separate realization of a particular class.

Given the class below, how do we create two different instances of this class
with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

My answer:
cat1 = AngryCat.new(1, "Browny")
cat2 = AngryCat.new(3, "Jaws")

Solution
When we create the AngryCat objects, we pass the constructor two values -- an age and a name.
These values are assigned to the new object's instance variables, and each object ends up
with different information.

To show this, lets create two cats.

henry = AngryCat.new(12, "Henry")
alex   = AngryCat.new(8, "Alex")

We now have two different instances of the AngryCat class.

You will have noticed there is no new method inside of the AngryCat class, so how does Ruby
know what to do when setting up the objects? By default, Ruby will call the initialize method
on object creation.

Now we can confirm that each of our cats are different by asking for their ages and names.

>> henry.name
Henry
>> henry.age
12
>> alex.name
Alex
>> alex.age
8

As you can see, they have two different sets of attributes from when they were created.

CONCEPTS
- Instantiate objects from a class
- ::new and initialize method
=end


=begin
Question 4

Given the class below, if we created a new instance of the class and then
called to_s on that instance we would get something like 
"#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end
end

How could we go about changing the to_s output on this method to look like this:
I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).


My answer:
The default to_s output of printing the class name and its encoded object_id
are from the to_s implementation in class Object which is a superclass to all created classes.
To change the to_s output, we need to override this method in our class with our required behaviour.
Note that to_s need to return a string, otherwise after executing our custom to_s, it will call
on Object.to_s again.

class Cat
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{type} cat"
  end
end


Solution
To do this we would need to override the existing to_s method by adding a method of the same
name as this to the class. It would look something like this:

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

Note that we have added a getter method which allows us to retrieve the type instance variable.

We can customize existing methods like this easily, but in many cases it might be better to write
a new method called something like display_type instead, as this is more specific about what we
are actually wanting the result of the method to be. An example of this would be:

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def display_type
    puts "I am a #{type} cat"
  end
end

CONCEPTS
- Override to_s method

=end


=begin
Question 5

If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model

My answer:
tv.manufacturer will result in NoMethodError as there is no instance method manufacturer in class Television
tv.model will invoke the model instance method

Television.manufacturer will invoke the manufacturer class method
Television.model will result in NoMethodError since there is no class method model in Television


Solution

If you attempted to call tv.manufacturer you would get an error and it would look something like this
undefined method manufacturer for #<Television:XXXX>, this is because tv is an instance of the class
Television and manufacturer is a class method, meaning it can only be called on the class itself
(in this case Television).

You would also get an error if you tried to call Television.model, the error would look something like
NoMethodError: undefined method 'model' for Television:Class. This is because this method only exists
on an instance of the class Television in this case tv.

CONCEPTS
- Differentiate between instance and class method
=end


=begin
Question 6

If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

In the make_one_year_older method we have used self. What is another way we could write
this method so we don't have to use the self prefix?

My answer:
def make_one_year_older
  @age += 1
end


Solution
self in this case is referencing the setter method provided by attr_accessor - this means that we
could replace self with @. So the revised method would look something like this:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end

This means in this case self and @ are the same thing and can be used interchangeably.


CONCEPTS
- self in instance method is needed to refer to a setter to differentiate from local variables
=end


=begin
Question 7

What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

My answer:
The attr_accessor for brightness and color are both not used in this example and may be removed


Solution
The answer here is the return in the information method. Ruby automatically returns the result of
the last line of any method, so adding return to this line in the method does not add any value
and so therefore should be avoided. We also never use the attr_accessor for brightness and color.
Though, these methods do add potential value, as they give us the option to alter brightness and
color outside the Light class.
=end


