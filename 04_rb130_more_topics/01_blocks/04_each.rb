# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end


# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation
  def add(todo)
    # raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo  (use instance_of? more readable)
    raise TypeError, "Can only add Todo objects" unless Todo === todo    
    
    @todos << todo 
  end

  # use the following instead of defining #<<
  # alias_method :add, :<<
  def <<(todo)  
    add(todo)
  end
  
  def size
    @todos.size
  end
  
  def first
    @todos.first
  end
  
  def last
    @todos.last
  end
  
  def to_a
    @todos.clone  # best to return a clone
  end
  
  def done?
    @todos.all? { |todo| todo.done? }
  end
  
  def item_at(index)
    @todos.fetch(index)
  end
  
  def mark_done_at(index)
    item_at(index).done!
  end
  
  def mark_undone_at(index)
    item_at(index).undone!
  end
  
  def done!
    @todos.each { |todo| todo.done! }
  end
  
  def shift
    @todos.shift
  end
  
  def pop
    @todos.pop
  end
  
  def remove_at(index)
    @todos.delete(item_at(index))
  end
  
  def to_s
    "---- #{title} ----\n" + @todos.map { |todo| todo.to_s }.join("\n")
    
    # Alternative Solution
    # text = "---- #{title} ----\n"
    # text << @todos.map(&:to_s).join("\n")
    # text
  end
  
  def each
    counter = 0
    while counter < @todos.size
      yield(@todos[counter]) if block_given?
      counter += 1
    end
    
    self
  end
  
end


# Test code
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end


=begin
# Give solution
class TodoList

  # ... rest of class omitted for brevity

  def each
    @todos.each do |todo|
      yield(todo)
    end
  end

end

We could have used a while loop (or any other loop, too) but since @todos
is an Array, we opted to use Array#each to iterate. We're yielding each
element in @todos to the block with the yield keyword.
=end
