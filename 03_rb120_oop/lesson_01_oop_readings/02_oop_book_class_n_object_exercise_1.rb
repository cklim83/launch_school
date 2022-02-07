=begin
Create a class called MyCar. When you initialize a new instance or object
of the class, allow the user to define some instance variables that tell
us the year, color, and model of the car. Create an instance variable that
is set to 0 during instantiation of the object to track the current speed
of the car as well. Create instance methods that allow the car to speed
up, brake, and shut the car off.
=end

class MyCar
  attr_accessor :year, :color, :model, :speed, :state
  
  def initialize(year, color, model, speed=0)
    self.year = year
    self.color = color
    self.model = model
    self.speed = speed
    self.state = "off"
  end
  
  def switch_on
    self.state = "on"
  end
  
  def switch_off
    self.speed = 0
    self.state = "off"
  end
  
  def accelerate
    p "Accelerating ..."
    self.speed += 10
  end
  
  def brake
    p "Braking ..."
    self.speed -= 10
  end
end

my_car = MyCar.new(2021, "white", "toyota")
my_car.accelerate
my_car.accelerate
p my_car.speed
my_car.brake
p my_car.speed
my_car.switch_off
p my_car.speed


=begin
Solution

class MyCar

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
lumina.current_speed
=end


=begin
Add an accessor method to your MyCar class to change and view the color
of your car. Then add an accessor method that allows you to view, but
not modify, the year of your car.
=end
class MyCar
  attr_accessor :color, :speed, :state
  attr_reader :year, :model
  
  def initialize(year, color, model, speed=0)
    @year = year
    @model = model    # we cannot use self.model since we only create a getter for @model
    self.color = color
    self.speed = speed
    self.state = "off"
  end
  
  def switch_on
    self.state = "on"
  end
  
  def switch_off
    self.speed = 0
    self.state = "off"
  end
  
  def accelerate
    p "Accelerating ..."
    self.speed += 10
  end
  
  def brake
    p "Braking ..."
    self.speed -= 10
  end
end

my_car = MyCar.new(2021, "white", "toyota")


=begin
class MyCar
  attr_accessor :color
  attr_reader :year
  # ... rest of class left out for brevity
end

lumina.color = 'black'
puts lumina.color
puts lumina.year
=end


=begin
You want to create a nice interface that allows you to accurately describe
the action you want your program to perform. Create a method called
spray_paint that can be called on an object and will modify the color of
the car.
=end

class MyCar
  attr_accessor :color, :speed, :state
  attr_reader :year, :model
  
  def initialize(year, color, model, speed=0)
    @year = year
    @model = model    # we cannot use self.model since we only create a getter for @model
    self.color = color
    self.speed = speed
    self.state = "off"
  end
  
  def switch_on
    self.state = "on"
  end
  
  def switch_off
    self.speed = 0
    self.state = "off"
  end
  
  def accelerate
    p "Accelerating ..."
    self.speed += 10
  end
  
  def brake
    p "Braking ..."
    self.speed -= 10
  end
  
  def spray_paint(new_color)
    puts "Spray painting car from #{color} to #{new_color}..."
    self.color = new_color
  end
end

my_car = MyCar.new(2021, "white", "toyota")
p my_car.color
my_car.spray_paint("blue")
p my_car.color


=begin
Solution

class MyCar
  attr_accessor :color
  attr_reader :year

  # ... rest of class left out for brevity

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end
end

lumina.spray_paint('red')   #=> "Your new red paint job looks great!"
=end