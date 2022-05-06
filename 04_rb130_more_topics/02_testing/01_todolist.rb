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
  
  def select
    list = TodoList.new(title)
    each do |todo| 
      list << todo if yield(todo)  
    end

    list
  end
  
  # find_by_title 	takes a string as argument, and returns the first Todo object that matches the argument. Return nil if no todo is found.
  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end
  
  # all_done 	returns new TodoList object containing only the done items
  def all_done
    select { |todo| todo.done? }
  end
  
  # all_not_done 	returns new TodoList object containing only the not done items
  def all_not_done
    select { |todo| !todo.done? }
  end
  
  # mark_done 	takes a string as argument, and marks the first Todo object that matches the argument as done.
  def mark_done(title)
    find_by_title(title).done!  # should be find_by_title(title) && find_by_title(title).done! as the title may not be found
  end
  
  # mark_all_done 	mark every todo as done
  def mark_all_done
    all_not_done.each { |todo| todo.done! }  # should just iterate with each else new list is returned
  end
  
  # mark_all_undone 	mark every todo as not done
  def mark_all_undone
    all_done.each { |todo| todo.undone! }  # should just iterate with each else new list is returned
  end
end


=begin
Given Solution:

class TodoList

  # ... rest of code omitted for brevity

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end
=end

