=begin
Question 1

Which of the following are objects in Ruby? If they are objects,
how can you find out what class they belong to?

1. true
2. "hello"
3. [1, 2, 3, "happy days"]
4. 142

My answer:
They are all objects in Ruby. To determine the class they belong,
we invoke the #class method provided by Kernel module


Solution:
All of them are objects! Everything in Ruby is an object, so you
never need to ask yourself "is this an object?" because the answer
every time will be yes.

You can find out what class an object belongs to in Ruby by asking
the object what its class is by calling the method class on the
object, as you can see below:

irb :001 > true.class
=> TrueClass
irb :002 > "hello".class
=> String
irb :003 > [1, 2, 3, "happy days"].class
=> Array
irb :004 > 142.class
=> Integer


CONCEPTS
- recognise objects in Ruby
- Find the class using #class instance method provided by Kernel module
=end


=begin
Question 2

If we have a Car class and a Truck class and we want to be able to go_fast,
how can we add the ability for them to go_fast using the module Speed?
How can you check if your Car or Truck can now go fast?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end


My answer:
To allow both Car and Truck to have the go_fast behavior,
we can include the Speed module in both class definitions
To ensure they can both use the go_fast method, we can create 
and instance of each class and invoke that method

=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

my_car = Car.new
my_car.go_fast
my_truck = Truck.new
my_truck.go_fast

=begin

Solution

In order to give the go_fast method to the Truck and the Car we need to
include the module that has that method. To do this we need to add
include Speed to each of the classes, like this:

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Now that everything looks right, how do we confirm that our
Truck and Car can actually go_fast? The answer is to try it:

irb :001 > blue_truck = Truck.new
irb :002 > blue_truck.go_fast
I am a Truck and going super fast!

irb :003 > small_car = Car.new
irb :004 > small_car.go_fast
I am a Car and going super fast!

As you can see we can now go fast in our Car and Truck.


CONCEPTS
- include modules in class

=end


=begin
Question 3

In the last question we had a module called Speed which contained
a go_fast method. We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

When we called the go_fast method from an instance of the Car class
(as shown below) you might have noticed that the string printed when
we go fast includes the name of the type of vehicle we are using. How
is this done?

>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!


My answer:
The type of vehicle is printed by string interpolation of self.class
method invocation. self here refers to the car object referenced by 
small_car so self.class will return Car class which is interpolated 
in the string to be printed out. 


Solution:

We use self.class in the method and this works the following way:

1. self refers to the object itself, in this case either a Car or Truck object.
2. We ask self to tell us its class with .class. It tells us.
3. We don't need to use to_s here because it is inside of a string and is
   interpolated which means it will take care of the to_s for us.


CONCEPTS
- Meaning of self in instance method from a module

TO REVIEW
- String interpolation automatically calls to_s on the Car class to convert
  it to string to be output.
=end


=begin
Question 4

If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
=end

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

tom = AngryCat.new
# Using the ::new class method, we can create a new instance of this class.

=begin
Solution:
You can define a new instance of the AngryCat class like this:

AngryCat.new

Using the .new after the class name will tell Ruby this new
object is an instance of AngryCat.


CONCEPTS
- Using ::new to create an object instance
=end


=begin
Question 5

Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end


My answer:
Pizza has a instance variable called @name. Instance variables begin with @.
The name in Fruit is not an instance variable but will be interpretated as a
local variable.

Solution:
You can find out if an object has instance variables by either looking
at the class or asking the object. First, lets look at the class definitions.

You might have noticed in the Pizza class there is a variable where the
variable name starts with an @ symbol. This means that this class has an
instance variable.

But let us be triple sure that only Pizza has an instance variable by
asking our objects if they have instance variables.

To do this we first need to create a Pizza object and a Fruit object.

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

Now we can ask each of these objects if they have instance variables.

>> hot_pizza.instance_variables
=> [:@name]
>> orange.instance_variables
=> []

As you can see, if we call the instance_variables method on the instance
of the class we will be informed if the object has any instance variables
and what they are.

By doing this we have found out that Pizza has instance variables while
Fruit does not.


CONCEPTS
- Recognizing instance variables
- Finding instance variables using #instance_variables
- Unitialized instance variables not in state and as good as absent

TO REVIEW
- We can call #instance_variables on the object to check if it has any
  instance variables
  
- If the instance variable of an object is not initialized, it will be appear
  in the state and also the array returned by #instance_variables method call
  (see illustration below)
  
  class Car
    def name=(n)
      @name =n
    end
  end
  
2.6.3 > car = Car.new
 => #<Car:0x00000000026026e0> 
2.6.3 > car.instance_variables
 => [] 
2.6.3 > car.name = "Toyota"
 => "Toyota" 
2.6.3 > car.instance_variables
 => [:@name] 

=end


=begin
Question 6

What could we add to the class below to access the instance variable @volume?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

=end

# Answer: add and attr_reader to retrieve @volume, attr_writer if we want
# to write to it
class Cube
  attr_reader :volume
  def initialize(volume)
    @volume = volume
  end
end

my_cube = Cube.new(15)
p my_cube.volume

=begin
Solution:
Technically we don't need to add anything at all. We are able to access
instance variables directly from the object by calling instance_variable_get
on the instance. This would return something like this:

>> big_cube = Cube.new(5000)
>> big_cube.instance_variable_get("@volume")
=> 5000

While this works it is generally not a good idea to access instance variables
in this way. Instead we can add a method to this object that returns the
instance variable.

An example of this would be adding a method called get_volume:

class Cube
  def initialize(volume)
    @volume = volume
  end

  def get_volume
    @volume
  end
end

Now if we call get_volume on our big_cube we will get:

>> big_cube.get_volume
=> 5000


CONCEPTS
- Using getters to access instance variables

TO REVIEW
- Calling #instance_variable_get("@variable_name") on the object will return the value 
  of the instance variable

- We can create our own custom getter method

- We can also use the attr_reader method provided by Ruby

=end


=begin
Question 7

What is the default return value of to_s when invoked on an object?
Where could you go to find out if you want to be sure?

My answer:
The default return value of to_s called on an object is
the Class Name and its encoded object_id. This behaviour 
is inherited from Object superclass

https://docs.ruby-lang.org/en/master/Object.html#method-i-to_s

Solution:

By default, the to_s method will return the name of the object's
class and an encoding of the object id.

If you weren't sure of this answer you could of course refer to
Launch School's Object Oriented Programming book, but you could
also refer directly to the Ruby documentation, in this case,
here: http://ruby-doc.org/core/Object.html#method-i-to_s.


CONCEPTS
- default to_s instance method from Object superclass

=end


=begin
Question 8

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

You can see in the make_one_year_older method we have
used self. What does self refer to here?

My answer:
This self refers to the calling object, which is an instance
of Cat.

Solution:
Firstly it is important to note that make_one_year_older is
an instance method and can only be called on instances of the
class Cat. Keeping this in mind the use of self here is
referencing the instance (object) that called the method - the calling object.


CONCEPT
- Meaning of self in instance method
=end


=begin
Question 9

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

In the name of the cats_count method we have used self.
What does self refer to in this context?

My answer:
self within a class definition but outside an instance method
refers to the class itself. Hence self here refers to the class Cat.

Solution:
Because this is a class method it represents the class itself, in this case Cat.
So you can call Cat.cats_count.


CONCEPTS
- MEaning of self outside instance method (define class method)
=end


=begin
Question 10

If we have the class below, what would you need to call to create a
new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

My answer:
We call the class method ::new on the Bag class and supply it 
with two arguments, a value for color and a value for material
to create a new Bag instance.

Solution:
If you tried to create a new instance of the bag by calling Bag.new you would
have received an error like the one below:

ArgumentError: wrong number of arguments (0 for 2)
  from (irb):in `initialize'
  from (irb):in `new'

This is Ruby telling us that we are missing some arguments and this is totally
correct.

As you can see from the initialize method, it is expecting two arguments. So as
long as we pass in two arguments this error will go away - for example we could
call this with Bag.new("green", "paper") and because this is providing the
arguments that are needed it will successfully create the instance without an
error.


CONCEPTS
- recogizing arguments needed to initialize a new instance
=end