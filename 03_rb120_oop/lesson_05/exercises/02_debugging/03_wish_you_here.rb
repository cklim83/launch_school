=begin
On lines 37 and 38 of our code, we can see that grace and ada are located
at the same coordinates. So why does line 39 output false? Fix the code to
produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false
=end

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
  
  def ==(other_location)
    latitude == other_location.latitude && 
    longitude == other_location.longitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true

=begin
My answer:
ada.location returns a Geolocation object which invokes the 
== method call for equality comparison. Since Geolocation
did not define a == instance method, the default == instance
method from BasicObject kicks in, resulting in a.equals?b comparison
Since the two geolocations are different object, the result
is false even though they have the same values. To solve this,
we override the default == method in Geolocation to one that 
compares the values of latitude and longtitude

Sidenote: Sometimes, we could also implement <=> and include Comparable
module in the class and we will get the other comparison methods i.e.
>, <, == etc automatically. Not applicable in this case and > and <
do not really make sense for lat, lon
=end


=begin
Solution

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def ==(other)
    latitude == other.latitude && longitude == other.longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

Discussion

On line 39 of our original code, we invoke the == method to compare the
equality of two locations. Since our GeoLocation class does not implement
==, Ruby invokes the method from the BasicObject class. BasicObject#==,
however, returns true only if the two objects being compared are the same
object, or in other words, if they have the same object id.

In order to compare the equality of instances of our custom class based on
the value of their attributes, we need to define a == method in our custom
class, which overrides BasicObject#== (thanks to Ruby's method lookup path).
GeoLocation#== does exactly that: it compares two locations based on their
latitude and longitude values.
=end