require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative '01_todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end
  
  def test_size
    assert_equal(@todos.size, @list.size)
  end
  
  def test_first
    assert_equal(@todo1, @list.first)
  end
  
  def test_last
    assert_equal(@todo3, @list.last)
  end
  
  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end
  
  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end
  
  def test_done?
    assert_equal(false, @list.done?)
  end
  
  def test_add_raise_error
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add('hi') }
  end
  
  def test_add_alias
    todo4 = Todo.new("Pack bag")
    @list << todo4
    @todos << todo4
    assert_equal(@todos, @list.to_a)
  end
  
  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) { @list.item_at(100) }
  end
  
  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
    
    # Note: The following will fail the test as @todo2.done? is executed first and returns false
    #       while @list.mark_done_at(1) will return true. Best to follow above test
    assert_equal(@todo2.done?, @list.mark_done_at(1)) 
  end
  
  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(100) }
    
    @list.mark_all_done  # Note: best to do @todo1.done!, @todo2.done!, @todo3.done! as than we do not need to be sure mark_all_done works at this point.
    
    @list.mark_undone_at(1)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end
  
  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    
    removed_obj = @list.remove_at(1)
    assert_equal(@todo2, removed_obj)
    assert_equal([@todo1, @todo3], @list.to_a)
  end
  
  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
    
    # Note: As of Ruby 2.3, we can remove leading spaces and trailing newlines using <<~
    # The heredoc can thus be written as follows
    
    # <<~OUTPUT.chomp
    # ---- Today's Todos ----
    # [ ] Buy milk
    # [ ] Clean room
    # [ ] Go to gym
    # OUTPUT
  end
  
  def test_to_s_one_done
    @list.mark_done_at(2)
    
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [X] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end
  
  def test_to_s_all_done
    @list.mark_done_at(0)
    @list.mark_done_at(1)
    @list.mark_done_at(2)
    
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end
  
  def test_each
    new_list = []
    @list.each { |todo| new_list << todo }
    assert_equal([@todo1, @todo2, @todo3], new_list)
  end
  
  def test_each_return_original_list
    assert_equal(@list, @list.each { |todo| nil })
  end
  
  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
  
  # Added following test into improve code coverage
  def test_find_by_title
    
    # First item found
    todo4 = Todo.new("Buy milk", "Second copy")
    found = @list.find_by_title("Buy milk")
    assert_equal(@todo1, found)
    
    # Item not found
    assert_equal(nil, @list.find_by_title("New item"))
  end
  
  def test_all_done
    @todo2.done!
    @todo3.done!
    
    list = TodoList.new(@list.title)
    list.add(@todo2)
    list.add(@todo3)
    
    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.all_done.to_s)
  end
  
  def test_mark_done_title
    todo4 = Todo.new("Buy milk", "second copy")
    @list.add(todo4)
    @list.mark_done("Buy milk")
    @list.mark_done("Go to gym")
    
    assert_equal([@todo1, @todo3], @list.all_done.to_a)
    
    # Could test mark_done for non-existance title and code error NoMethodError for nil class will surface
  end
  
  def test_mark_all_undone
    @todo1.done!
    @todo2.done!
    @todo3.done!
    @list.mark_all_undone
    assert_equal([@todo1, @todo2, @todo3], @list.all_not_done.to_a)
  end
end