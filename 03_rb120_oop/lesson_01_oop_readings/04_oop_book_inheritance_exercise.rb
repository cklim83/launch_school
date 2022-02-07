=begin
Create a superclass called Vehicle for your MyCar class to inherit from
and move the behavior that isn't specific to the MyCar class to the
superclass. Create a constant in your MyCar class that stores information
about the vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass
that also has a constant defined that separates it from the MyCar class
in some way.
=end

class Vehicle
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end


=begin
Add a class variable to your superclass that can keep track of the number of
objects created that inherit from the superclass. Create a method to print
out the value of this class variable as well.
=end

class Vehicle
  @@vehicle_count = 0
  
  def initialize
    @@vehicle_count += 1
  end
  
  def self.vehicle_count
    puts "#{@@vehicle_count} vehicle objects have been created!"
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end

Vehicle.vehicle_count
car_1 = MyCar.new
truck_1 = MyTruck.new
Vehicle.vehicle_count


=begin
Solution

class Vehicle
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  #code omitted for brevity...
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end
=end



=begin
Create a module that you can mix in to ONE of your subclasses that
describes a behavior unique to that subclass. Print to the screen your
method lookup for the classes that you have created.
=end

module Loadable
  def load_goods
    puts "Loading goods ..."
  end
end

class Vehicle
  @@vehicle_count = 0
  
  def initialize
    @@vehicle_count += 1
  end
  
  def self.vehicle_count
    puts "#{@@vehicle_count} vehicle objects have been created!"
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include Loadable
  NUMBER_OF_DOORS = 2
  
end

truck_1 = MyTruck.new
p truck_1.ancestors
p MyTruck.ancestors  # undefined method `ancestors' for #<MyTruck:0x0000000001b61c40> (NoMethodError)

=begin
Solution

module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  #code omitted for brevity...
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
end

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

TO REVIEW
- ancestor is a class method and not an instance method
- module name should also be CamelCase, like class name
=end


=begin
5) Move all of the methods from the MyCar class that also pertain to the
MyTruck class into the Vehicle class. Make sure that all of your previous
method calls are working when you are finished.

6) Write a method called age that calls a private method to calculate the
age of the vehicle. Make sure the private method is not available from
outside of the class. You'll need to use Ruby's built-in Time class to help.
=end

module Loadable
  def load_goods
    puts "Loading goods ..."
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model
  @@vehicle_count = 0
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@vehicle_count += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end
  
  def age
    puts "Your #{self.model} is #{calculate_age} years old"
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def self.vehicle_count
    puts "#{@@vehicle_count} vehicle objects have been created!"
  end
  
  private
  def calculate_age
    Time.new.year - self.year
  end
  
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

class MyTruck < Vehicle
  include Loadable
  NUMBER_OF_DOORS = 2
  
  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors
puts lumina.age


=begin
Create a class 'Student' with attributes name and grade. Do NOT make the grade
getter public, so joe.grade will raise an error. Create a better_grade_than?
method, that you can call like so...

puts "Well done!" if joe.better_grade_than?(bob)
=end

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(another_student)
    grade > another_student.grade
  end
  
  private
  def grade
    @grade
  end
end


joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)

=begin
Solution

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)
=end

=begin
TO REVIEW
- We can call protected methods on other objects of the same class inside the
  Class definition. However, this cannot be done for private methods but not
  for private methods
  
- Both protected and private methods cannot be called outside the class definition on
  objects of that class
=end


=begin
Given the following code...

bob = Person.new
bob.hi

And the corresponding error message...

NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

What is the problem and how would you go about fixing it?

My answer:
`hi` is a private a method and cannot be accessed outside by an object.
We can solve this my making it a public method by shift it before any private and protected
method calls.

=end

=begin
Solution:

The problem is that the method hi is a private method, therefore it is unavailable
to the object. I would fix this problem by moving the hi method above the private method
call in the class.
=end