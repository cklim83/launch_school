=begin
Correct the following program so it will work properly. Assume that the
Customer and Employee classes have complete implementations; just make
the smallest possible change to ensure that objects of both types have
access to the print_address method.

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
=end

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
  
  include Mailable
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
  
  include Mailable
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address


=begin
Solution

class Customer
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

Discussion

Methods inside a module can be added to a class by simply including
the module into the class. Such modules are called mixin modules.
=end