# rubocop:disable all
=begin

Simple Linked List

Write a simple linked list implementation. The linked list is a fundamental
data structure in computer science, often used in the implementation of other
data structures.

The simplest kind of linked list is a singly linked list. Each element in the
list contains data and a "next" field pointing to the next element in the list
of elements. This variant of linked lists is often used to represent sequences
or push-down stacks (also called a LIFO stack; Last In, First Out).

Let's create a singly linked list whose elements may contain a range of data
such as the numbers 1-10. Provide functions to reverse the linked list and
convert a linked list to and from an array.
=end


=begin
Problem
- Construct a singly linked list
- Each element in list has data and a next field pointing to next element in 
  the list
- The linked list have the following functions 
  - reverse the list
  - convert linked list to array and vice versa

Examples and Test Cases
- Need to define an Element class with the following methods
  - constructor that takes 1 or 2 argument is an integer representing the datum,
    second one is an optional element that represent the next element this
    element can traverse to.
  - #datum that returns the data
  - #tail? that returns a boolean
  - #next that returns the next element
- A SimpleLinkedList class with following methods
  - A constructor that does not take any arguments
  - #size that return the number of elements
  - #empty? that returns a boolean
  - #push that creates an Element object with datum equalling the argument
    and appending it as the head of the list
  - When we push more than 1 element in linked list, they are stacked.
  - #head that return an Element object at the head position. The head is always
    at the most recent datum pushed in
  - #peek that return the datum at head or nil if list is empty
  - #pop remove the element object at head, then returns the datum of that
    object. The next item of the removed element becomes the new head.
  -::from_a static/class method that accepts 
    - [] empty array, generate an empty list.
    - nil, generate empty list
    - [1, 2] integer array, generate a list with same number of elements as
      the input array. The first array element will be the head of the list.
  - #to_a instance method, returns an array contain the datum of the list,
    with the head of list equals the start of the array. Does not mutate the 
    list.
  - #reverse instance method that reverse the order of the elements in the
    linked list.
    
Data Structures
- Element object
- Array as collaborator object of Linked List holding the elements in the list
- Instance variable tracking the next element in the list


Algorithm

Element Class
- constructor(data, [element_obj])
  - assign data to @datum 
  - assign element_obj to @next

- datum instance method
  - return @datum

- tail? instance method
  - return whether @next is nil

- next instance method
  - return @next

SimpleLinkedList class
- constructor 
  - initialize @head to nil 
  
- size instance method
  - Return the number of elements in the list

- empty? instance method
  - Return true if list size is 0, otherwise return false

- push(data) instance method
  - Create a new Element object with data, @head as second argument to
    constructor
  - set @head to this new element

- head instance method
  - return @head
  
- peek instance method
  - return @head.datum, nil if @head is nil
  
- pop instance method
  - assign obj to @head 
  - assign @head to @head.next
  - return datum of obj

- from_a class method 
  - if argument is nil or [], return a new instance of simplelinkedlist
  - if argument is a non empty array, iterate through each number in array in 
    reverse order in the array, push that data into the list. The 1st element
    in array will then be last to be pushed in, and be the @head

- to_a instance method
  - Iterate from the @head, copy the datum to result array
  - return result array
  
- reverse instance method
  - get the data array
  - reverse the data array
  - return a new list created using ::from_a(reversed data array)
  
=end  
# rubocop:enable all

class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(data, next_element = nil)
    @datum = data
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  def initialize
    @head = nil
  end

  def size
    return 0 if @head.nil?

    hops = 1
    current_element = @head
    until current_element.next.nil?
      hops += 1
      current_element = current_element.next
    end

    hops
  end

  def empty?
    size == 0
  end

  def push(number)
    new_element = Element.new(number, @head)
    @head = new_element
  end

  def head
    @head.clone
  end

  def peek
    return nil unless @head
    @head.datum
  end

  def pop
    old_head = @head
    @head = @head.next
    old_head.next = nil
    old_head.datum
  end

  def self.from_a(items)
    new_list = SimpleLinkedList.new

    items&.reverse_each do |item|
      new_list.push(item)
    end

    new_list
  end

  def to_a
    result = []
    current_element = @head
    while current_element
      result << current_element.datum
      current_element = current_element.next
    end

    result
  end

  def reverse
    SimpleLinkedList.from_a(to_a.reverse)
  end
end

# rubocop:disable all
=begin
PEDAC Solution

Undestanding the Problem
  For our program, the details we need to keep in mind are as follows:

    - We'll be making a singly linked list. This means that each element in the
      list does not need to have information about any other element in the list
      except for the next element.
    
    - Each element in the list contains data (a value) and a next field that
      points to the next element in the list of elements.
    
    - The elements of our linked list may contain any data values.
    
    - We'll need a method that reverses a linked list, as well as methods that
      convert a linked list to and from an array.
    
    - We may need to also write several helper methods.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create two
  classes: Element and SimpleLinkedList.

The Element class should have several methods as follows:

    a constructor that expects at least one argument. The first argument is
    the data value to be stored in the newly created element. The second
    optional argument is another Element object that will be the next element
    after the newly created element. If it seems odd to you that the more
    recently created element would be placed before the already-existing
    element, remember that our linked list is meant to resemble a
    push-down/pop-off stack. With such stacks, the most recently added
    (pushed) elements are the ones that get removed (popped) first. They
    are commonly known as LIFO stacks: Last In, First Out.

    a method that returns the data value of the Element.

    a method that returns a boolean that indicates whether the current element
    is the tail of the list: the last one in the list. The tail element does
    not have another Element instance stored in the next field.

    a method that returns the next Element in the linked list. If the current
    element is the tail, we should return a value indicating the absence of a
    next element (e.g., null or nil).

The SimpleLinkedList class should have several methods as follows:

    a class or static method that creates a new SimpleLinkedList instance from
    a given array argument.

    a class or static method that converts a SimpleLinkedList instance into
    an array. The datum from each link in our list should be an element in
    the returned array.

    a method that adds its argument to the list.

    a method that removes the head of the list (the most recently added item
    on the list).

    a method that returns the Element at the head of the list.

    a method that returns the size of the list.

    a method that returns a boolean based on whether or not the list is empty.

    a method that returns the data value of the head element.

    a method that returns the list but in reverse order.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structures
  The data values in a list can be any sort of value. Each Element object
  encapsulates a value, regardless of its type.


Hints and Questions
  The second argument for the Element constructor is optional. Use some sort
  of default value when the argument is omitted that can't possibly be seen as
  a valid next element.

  The method used to create an array from a linked list should not mutate the
  linked list used to call it.

  The method used to reverse a linked list should not mutate the linked list
  used to call it. Instead, it should return a new linked list.


Algorithm

Element
    constructor
        Save the first argument as the new Element's constructor
        Save the second argument as the next Element
            If the second argument is omitted, use an appropriate default value.

    Method: datum
        Return the Element's value.

    Method: Is this element the tail? (Ruby: tail?; JavaScript: isTail)
        If this Element doesn't have a next Element, return true.
        Otherwise, return false.

    Method: next
        Return the next Element (an Element object).


SimpleLinkedList
    constructor
        Set the object's head property/instance variable to an initial value
        that indicates an empty list.

    Class/Static Method: convert array to linked list 
    (Ruby: from_a; JavaScript: fromArray)
        If array argument is omitted, use an empty array.
        Create a new instance of the SimpleLinkedList.
        For each element in the array, push the element's value to the new
        linked list.
        Return the new linked list.

    Method: convert linked list to array (Ruby: to_a; JavaScript: toArray)
        Create an empty array for the result.
        Set current element to head Element
        While the current element is a valid Element
            Append datum value of current element to result array
            Reassign the current element variable to the next Element.
        Return the result array.

    Method: push
        Create a new Element object with the value and next Element passed to
        push as its two arguments.
        Save the new Element object to the list as its new head Element.

    Method: pop
        Save the current head Element temporarily.
        Set the linked list's head Element to the value of the old head
        Element's next property/instance variable.
        Return the datum value of the old head Element.

    Method: head
        Return the first Element in the list.
        If the list is empty, return an appropriate value that indicates this.

    Method: size
        Set size to 0
        Set current element to head Element
        While the current element is a valid Element
            Increment size by 1
            Reassign the current element variable to the next Element.
        Return the size

    Method: is the list empty? (Ruby: empty?; JavaScript: isEmpty)
        Return true if the head of the list is a valid Element.
        Return false otherwise

    Method: peek
        Returns the datum value of the Element at the head of the list. If the
        list is empty, return a value that indicates this.

    Method: reverse
        Create a new empty linked list for the result.
        Set current element to head Element
        While the current element is a valid Element
            Create a new Element object using the datum of the current Element.
            Push the new Element object to the result list.
            Reassign the current element variable to the next Element.
        Return the result list.
        

Ruby Solution and Discussion

class Element
  attr_reader :datum, :next

  def initialize(datum, next_element = nil)
    @datum = datum
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def size
    size = 0
    current_elem = @head
    while (current_elem)
      size += 1
      current_elem = current_elem.next
    end
    size
  end

  def empty?
    @head.nil?
  end

  def push(datum)
    element = Element.new(datum, @head)
    @head = element
  end

  def peek
    @head.datum if @head
  end

  def pop
    datum = peek
    new_head = @head.next
    @head = new_head
    datum
  end

  def self.from_a(array)
    array = [] if array.nil?

    list = SimpleLinkedList.new
    array.reverse_each { |datum| list.push(datum) }
    list
  end

  def to_a
    array = []
    current_elem = head
    while !current_elem.nil?
      array.push(current_elem.datum)
      current_elem = current_elem.next
    end
    array
  end

  def reverse
    list = SimpleLinkedList.new
    current_elem = head
    while !current_elem.nil?
      list.push(current_elem.datum)
      current_elem = current_elem.next
    end
    list
  end
end

Each of our instances of Element have the attributes datum and next. We use
the next attribute along with other instances of Element in order to build
our linked list.

The SimpleLinkedList class uses its own push and pop methods to add and
remove elements from the front of the list in LIFO fashion. Note that we must
take care to re-assign the head attribute each time an element is added to or
removed from our linked list.

The SimpleLinkedList instance method peek merely returns the data value of
the head element, if one exists.

The to_a method creates a new empty array and then repeatedly adds the datum
value of each element on the linked list to the array.

SimpleLinkedList.from_a creates a new list, then adds the elements from the
array to the list, one at a time. Note that we need to add the elements in
reverse order to achieve the desired sequence.

Our SimpleLinkedList implementation of reverse works similarly to
SimpleLinkedList.from_a.
=end

