=begin

Bank Balance

We created a simple BankAccount class with overdraft protection, that
does not allow a withdrawal greater than the amount of the current
balance. We wrote some example code to test our program. However, we
are surprised by what we see when we test its behavior. Why are we
seeing this unexpected output? Make changes to the code so that we
see the appropriate behavior.

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

Hint 1: The bug in this code is extremely subtle. Think about what assignment returns in
other contexts. The return value of an assignment is completely predictable from what
appears on the right side of the = in the assignment.

Hint 2: Is #balance= returning what you the code suggests it is returning?
=end

class BankAccount
  attr_accessor :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0 && (balance - amount) > 0
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50


=begin
My answer:
success = (self.balance -= amount) in #withdraw returns the result of the arithmetic 
subtraction and not the boolean from #balance= method call. In this example, success
was assigned -30 which is a truthy value. Thus even though the balance was not updated
with the negative value, the truthy path "$#{amount} withdrawn. Total balance is $#{balance}."
is executed.
=end


=begin
Solution

class BankAccount
   # code omitted

  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    @balance = new_balance
  end

  # code omitted
end

Discussion

In Ruby, setter methods always return the argument that was passed in, even
when you add an explicit return statement. Our balance= method will therefore
always return its argument, irrespective of whether or not the instance variable
@balance is re-assigned.

Because of this behavior, the invocation of balance= on line 21 of the original
code will have a truthy return value even when our setter method does not
re-assign @balance; it will never return false.

A better solution is to check the validity of the transaction by calling
valid_transaction? in withdraw instead of balance=. If the transaction is
deemed valid, we then invoke balance=, otherwise we don't. This way we don't
attempt to use the setter for its return value, but instead let it do its one
job: assigning a value to @balance.

Further Exploration

What will the return value of a setter method be if you mutate its argument in
the method body?

The return value is the mutated argument, as seen below


Example: Argument to setter is mutated within setter method
class Person
  def initialize(name)
    @name = name
  end
  
  def name=(string)
    @name = string
    string[0]= 'x'
  end
end

tom = Person.new("Tom")
# => #<Person:0x0000000001e67f98 @name="Tom"> 
test = (tom.name = "Jason")                                                                                                                                                                                        
# => "xason" 
test
# => "xason" 
tom
# => #<Person:0x0000000001e67f98 @name="xason"> 

### In mutated argument example, the mutated argument is returned by setter method call


Example: Argument to setter is reassigned in setter method
# so that test returns 20
class Person
  def initialize(name)
    @name = name
    @age = nil
  end
  
  def age=(num)
    num += 99
    @age = num
  end
end

tom = Person.new("Tom")
# => #<Person:0x0000000001e67f98 @name="Tom"> 
test = (tom.age = 20)                                                                                                                                                                                        
# => 20 
test
# => 20 
tom
# => #<Person:0x0000000001e67f98 @name="Tom", @age=119> 

### In argument reassignment example, the original argument is returned by setter method call


CONCEPT
- setter methods always return the argument passed in rather than the method
  return value (e.g. the last evaluated expression or explicit return statements)

- If the argument to the setter is mutated in the setter method body, the mutated
  argument is the return value.
  
- If the argument to setter is reassigned in setter method body, the ORIGINAL argument
  is returned by the setter method call.

TO REVIEW (VERY IMPORTANT)
- Important concept on setter return value. (VERY IMPORTANT)
=end