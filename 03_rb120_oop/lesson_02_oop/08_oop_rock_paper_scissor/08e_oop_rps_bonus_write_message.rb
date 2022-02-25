require "yaml"

rpsls_messages = {
  welcome: <<~MSG,
    Welcome to the Rock, Paper, Scissor, Lizard and Spock game!
    This is a two-player game where each player chooses a move
    from amongst Rock, Paper, Scissor, Lizard or Spock. The
    winner will score a point while none will be awarded in the
    event of a tie. The first player to score 5 points wins this
    game.
  
  
    Enter 'moves' to view winning moves of this game, or press 
    enter to start the game ...
  MSG
  
  moves: <<~MSG,
    Winning Moves In This Game
    
    |---------|-----------------|
    |  Winner |     Loser       |
    |---------|-----------------|
    |  Rock   | Lizard, Scissor |
    |  Paper  | Rock, Spock     |
    | Scissor | Paper, Lizard   |
    |  Lizard | Paper, Spock    |
    |  Spock  | Scissor, Rock   |
    |---------|-----------------|
    
    Press enter to start the game ...
  MSG
  
  player_choice: "Please choose Rock(r), Paper(p), Scissor(sc), "\
                 "Lizard(l) or Spock(sp).",
                 
  invalid_choice: "You have entered an invalid choice. Please try again!",
            
  goodbye: "Thanks for playing Rock, Paper, Scissor, Lizard "\
           "and Spock game. Good bye!"
}

File.write("08f_rpsls_messages.yml", rpsls_messages.to_yaml)