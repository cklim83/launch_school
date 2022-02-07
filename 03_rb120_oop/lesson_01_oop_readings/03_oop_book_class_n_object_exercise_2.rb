=begin
1) Add a class method to your MyCar class that calculates the gas mileage of any car.
2) Override the to_s method to create a user friendly print out of your object.
=end

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
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
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def to_s
    "#{self.color} #{@model} made in year #{self.year}"
  end
end

MyCar.gas_mileage(13, 351)  # => "27 miles per gallon of gas"

car = MyCar.new(2021, "Audi", "Gray")
puts car


=begin
When running the following code...

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

We get the following error...

test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

Why do we get this error and how do we fix it?

My answer:
We only have an reader for the name attribute but we are trying
to invoke a setter to change the attribute's value. We can fix this by
creating a attr_accessor for the name attribute.

=end

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
p bob.name


=begin
We get this error because attr_reader only creates a getter method. When we try to reassign
the name instance variable to "Bob", we need a setter method called name=. We can get this
by changing attr_reader to attr_accessor or attr_writer if we don't intend to use the getter
functionality.

class Person
  attr_accessor :name
  # attr_writer :name ## => This also works but doesn't allow getter access
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
=end