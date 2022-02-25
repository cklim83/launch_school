=begin
Consider the following class definition:

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

There is nothing technically incorrect about this class, but the definition
may lead to problems in the future. How can this class be fixed to be
resistant to future problems?

Hint: Consider what might happen if you leave this class defined as it is, and
later decide to alter the implementation so that a database is not used.
=end

=begin
My answer: 
Current implementation will tie the initialization of a new database with 
new flight object creation. If we subsequently decided not to use a database,
we have to alter this method. To avoid coupling the creation of a database with each
instance creation, we should move the database creation out of initialize to a 
private/protected method.
=end


=begin
Solution

Delete the following line:

attr_accessor :database_handle

Discussion

The problem with this definition is that we are providing easy access to the
@database_handle instance variable, which is almost certainly just an
implementation detail. As an implementation detail, users of this class
should have no need for it, so we should not be providing direct access to it.

The fix is easy: don't provide the unneeded and unwanted attr_accessor.

What can go wrong if we don't change things? First off, by making access
to @database_handle easy, someone may use it in real code. And once that
database handle is being used in real code, future modifications to the
class may break that code. You may even be prevented from modifying your
class at all if the dependent code is of greater concern.


TO REVIEW
- Do not provide unnecessary handlers to databases. Once others use the
  handler in code, we will not be able to modify this class.
=end