=begin
Behold this incomplete class for constructing boxed banners.

class Banner
  def initialize(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line,
     empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
  end

  def empty_line
  end

  def message_line
    "| #{@message} |"
  end
end

Complete this class so that the test cases shown below work as intended.
You are free to add any methods or instance variables you need. However,
do not make the implementation details public.

You may assume that the input will always fit in your terminal window.

Test Cases

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+
=end

# class Banner
#   def initialize(message)
#     @message = message
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line,
#     empty_line, horizontal_rule].join("\n")
#   end

#   private
  
#   attr_reader :message
  
#   def horizontal_rule
#     format_string("+", "-")
#   end

#   def empty_line
#     format_string("|", " ")
#   end

#   def message_line
#     "| #{@message} |"
#   end
  
#   def format_string(border_string, filler)
#     "#{border_string}#{filler * (message.size + 2)}#{border_string}"
#   end  
# end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner

# banner = Banner.new('')
# puts banner


=begin
Solution

class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def empty_line
    "| #{' ' * (@message.size)} |"
  end

  def horizontal_rule
    "+-#{'-' * (@message.size)}-+"
  end

  def message_line
    "| #{@message} |"
  end
end

Discussion

Our solution simply adds an instance variable where we store the message
that will be bannerized, and then fills out the empty_line and
horizontal_rule methods for constructing the first, second, fourth, and
fifth lines of the banner. The only tricky part in these two methods is
remembering to allow for extra characters to the left and right so
everything is aligned.

Further Exploration

Modify this class so new will optionally let you specify a fixed banner
width at the time the Banner object is created. The message in the banner
should be centered within the banner of that width. Decide for yourself
how you want to handle widths that are either too narrow or too wide.
=end

class Banner
  MAX_WIDTH = 80
  
  def initialize(message, width=nil)
    @message = message
    
    min_width = nil
    if message.empty?
      min_width = 0
    else
      max_length = (message.split.map { |word| word.size }).max
      min_width = [max_length, MAX_WIDTH].min
    end
    
    if width.nil?
      @width = [message.size, MAX_WIDTH].min
    else
      @width = (width >= min_width ? [width, MAX_WIDTH].min : min_width)
    end
    
    puts ""
    puts "Longest word length: #{min_width}"
    puts "Entered Width: #{width}"
    puts "Final width: #{@width} (between #{min_width} & #{MAX_WIDTH}) "
  end

  def to_s
    [horizontal_rule, empty_line, message_line,
    empty_line, horizontal_rule].join("\n")
  end

  private
  
  attr_reader :message, :width
  
  def horizontal_rule
    format_string("+", "-")
  end

  def empty_line
    format_string("|", " ")
  end

  def message_line
    lines = wrap_text
    return "| " + " " * width + " |" if lines.empty?
    
    formatted_lines = lines.map do |line|
      "| " + line.center(width, " ") + " |"
    end
    formatted_lines.join("\n")
  end
  
  def wrap_text
    wrapped_lines = []
    words = message.split
  
    left_index = 0
    right_index = left_index
  
    while left_index < words.size
      line = words[left_index..right_index].join(' ')
      if right_index + 1 < words.size &&
         words[left_index..(right_index+1)].join(' ').size <= width
         # line can accommodate 1 more word within width
        right_index += 1
      else
        # line already at max length
        wrapped_lines << line
        left_index = right_index + 1
        right_index = left_index
      end
    end
  
    wrapped_lines
  end
    
  def format_string(border_string, filler)
    "#{border_string}#{filler * (width + 2)}#{border_string}"
  end  
end

banner = Banner.new('To boldly go where no one has gone before.
                     This is going to be a very long message', 30)
puts banner

banner = Banner.new('To boldly go where.', 60)
puts banner

banner = Banner.new('This message has a unusually long word: webjkjnbcewnlnewbnljfnblwnenlgehwhrb.
                     This is going to be a very long message', 30)
puts banner

banner = Banner.new('')
puts banner



# def wrap_text(message, width)
#   wrapped_lines = []
#   words = message.split
  
#   left_index = 0
#   right_index = left_index
  
#   while left_index < words.size
#     line = words[left_index..right_index].join(' ')
#     if right_index + 1 < words.size &&
#       words[left_index..right_index+1].join(' ').size <= width
#       right_index += 1
#     else
#       # line already at max length
#       wrapped_lines << line
#       left_index = right_index + 1
#       right_index = left_index
#     end
#   end
  
#   wrapped_lines
# end

# p wrap_text("this is a very long message to be wrapped into many lines!!!", 10)
# p wrap_text("", 10)
# p wrap_text("this is a very long messageshihikmlso to be wrapped into many lines!!!", 10)