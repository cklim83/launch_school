DEALER_THRESHOLD = 18
GAME_THRESHOLD = 21

# rubocop:disable Metrics/MethodLength
def welcome
  msg = <<-TXT
-------------------------------------------------------------------------
***************        TWENTY-ONE POINT POKER GAME         **************
-------------------------------------------------------------------------
Welcome to the TWENTY-ONE poker game. As the name suggests, the objective 
of the game is to get the highest points from the cards at hand without
breeching 21 points. Cards with numerics are worth the points printed.
'J', 'Q', 'K' are worth 10 points each while 'A' are worth either 1 or 11
points, depending on which is more advantageous based on the cards on hand.
Player and dealer will each begin with two cards. They can then choose "hit"
to get additional card(s) from the deck or "stay" once they have enough.
If their point total exceeds 21 at any point after hitting, they are
deemed to have gone "bust" and loses the game. 

Have fun and good luck!

Press any key to start the game ...

  TXT

  system "clear"
  puts msg
end
# rubocop: enable Metrics/MethodLength

def prompt(message)
  puts "=> #{message}"
end

def initialize_deck
  numbers = (2..10).to_a + ['J', 'Q', 'K', 'A']
  shapes = ['Diamond', 'Club', 'Heart', 'Spade']
  deck = numbers.product(shapes)
  deck.shuffle
end

def hit!(current_hand, deck)
  current_hand << deck.shift
end

def deal!(deck)
  current_hand = []
  2.times { hit!(current_hand, deck) }
  current_hand
end

def display_cards(cards, player, extent="all")
  if extent == "first"
    prompt "#{cards.first.first}, #{cards.first.last}"
  elsif extent == 'last'
    prompt "#{player} draw: #{cards.last.first}, #{cards.last.last}"
  else
    prompt "#{player} cards: #{cards}"
  end
end

def display_dealer_card(cards)
  prompt "Showing dealer's first card:"
  display_cards(cards, "Dealer", "first")
end

def best_point(points)
  return points.min if points.min > GAME_THRESHOLD
  points.select { |num| num <= GAME_THRESHOLD }.max
end

def calculate_points(cards)
  ace_count = 0
  subtotal_points = 0

  cards.each do |card|
    if card[0] == 'A'
      ace_count += 1
    elsif %w(J Q K).include?(card[0])
      subtotal_points += 10
    else
      subtotal_points += card[0]
    end
  end

  possible_points = [1, 11].repeated_combination(ace_count).map do |array|
    array.sum + subtotal_points
  end

  best_point(possible_points)
end

def display_points(points)
  prompt "These cards are worth #{points} points."
end

def hit_or_stay
  choice = nil
  loop do
    prompt "Would you like to hit or stay?"
    choice = gets.chomp.downcase
    break if %w(hit h stay s).include?(choice)
    prompt "Invalid input!"
  end

  choice
end

def player_turn!(player_cards, points, deck)
  loop do
    display_cards(player_cards, "Player")
    points[:player] = calculate_points(player_cards)
    display_points(points[:player])
    break if points[:player] > GAME_THRESHOLD

    choice = hit_or_stay
    break unless choice == 'hit' || choice == 'h'
    hit!(player_cards, deck)
    display_cards(player_cards, "Player", "last")
  end
end

def bust?(points)
  points > GAME_THRESHOLD
end

def dealer_turn!(cards, points, deck)
  loop do
    display_cards(cards, "Dealer")
    points[:dealer] = calculate_points(cards)
    display_points(points[:dealer])

    break unless points[:dealer] < DEALER_THRESHOLD
    hit!(cards, deck)
    display_cards(cards, "Dealer", "last")
  end
end

def determine_winner(round_points)
  if bust?(round_points[:player])
    :dealer
  elsif bust?(round_points[:dealer])
    :player
  elsif round_points[:dealer] > round_points[:player]
    :dealer
  elsif round_points[:dealer] < round_points[:player]
    :player
  end # return nil if scores are tied
end

def display_score(score)
  puts ""
  puts "-------------------"
  puts "   Current Score   "
  puts "-------------------"
  puts "  You      Dealer  "
  puts "   #{score[:player]}    :    #{score[:dealer]}    "
  puts ""
end

def update_score!(score, round_points)
  winner = determine_winner(round_points)
  if winner == :dealer
    score[:dealer] += 1
  elsif winner == :player
    score[:player] += 1
  end
end

def display_round_winner(points)
  return prompt "You bust, Dealer won this round!" if bust?(points[:player])
  return prompt "Dealer bust, you won this round!" if bust?(points[:dealer])

  prompt "You have #{points[:player]} points!"
  prompt "Dealer have #{points[:dealer]} points!"

  winner = determine_winner(points)
  if winner == :dealer
    prompt "Dealer won this round!"
  elsif winner == :player
    prompt "You won this round!"
  else
    prompt "It's a tie!"
  end
end

def display_grand_winner(score)
  if score[:dealer] == 5
    prompt "Dealer is the overall winner!"
  else
    prompt "Congrats, you are the overall winner!"
  end
end

def play_again?
  choice = nil
  loop do
    prompt "Would you like to play again (yes or no) ?"
    choice = gets.chomp.downcase
    break if %w(yes y no n).include?(choice)
    prompt "Invalid input!"
  end
  choice == "yes" || choice == 'y'
end

welcome
_ = gets

loop do
  score = { player: 0, dealer: 0 }

  loop do
    system "clear"
    prompt "Initializing the card deck ..."
    deck = initialize_deck
    points = { player: 0, dealer: 0 }

    prompt "Dealing ..."
    player_cards = deal!(deck)
    dealer_cards = deal!(deck)
    display_dealer_card(dealer_cards)

    player_turn!(player_cards, points, deck)

    dealer_turn!(dealer_cards, points, deck) unless bust?(points[:player])

    update_score!(score, points)
    display_round_winner(points)
    display_score(score)

    break if score[:dealer] == 5 || score[:player] == 5

    prompt "Press any button to start the next round ..."
    _ = gets
  end

  display_grand_winner(score)

  break unless play_again?
end

prompt "Thank you for playing. Goodbye!"
