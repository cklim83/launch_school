=begin

Game Description
Tic Tac Tow is a 2-player board game played on a 3x3 grid. Players take
turns marking a square. The first player to mark 3 squares in a line wins.

Extraction
Nouns: Board, Player, Grid, Square, Game
Verbs: Play, Mark

Organize
- Board (same as Grid)
- Square
- Player
  - Mark
  - Play
=end

# Spike
class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"
    # What data structure to use?
    # - array/hash of Square objects?
    # - array/hash of strings or integer?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of a square's mark?
  end
end

class Player
  def initialize
    # maybe a marker to track the player's symbol (i.e. 'X' or 'O')
  end
  
  def mark
  end
  
  def play
  end
end


# Lots of questions still remain about where responsibities lie, and how to
# cleanly organize the behaviors. There's still even the basic question of
# whether all the classes above are needed. For example, do we really need
# a Square or Player yet? It's not clear, and we really need to explore the
# problem a little to get a better feel for the code. One class we do need
# that we don't have yet is some sort of orchestration engine. 

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?
      
      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play