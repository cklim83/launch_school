=begin
Using the Card class from the previous exercise, create a Deck class that
contains all of the standard 52 playing cards. Use the following code to
start your work:

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
end

The Deck class should provide a #draw method to deal one card. The Deck
should be shuffled when it is initialized and, if it runs out of cards,
it should reset itself by generating a new set of 52 shuffled cards.

Examples:

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
drawn != drawn2 # Almost always.

Note that the last line should almost always be true; if you shuffle the
deck 1000 times a second, you will be very, very, very old before you see
two consecutive shuffles produce the same results. If you get a false
result, you almost certainly have something wrong.
=end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @cards = create_deck
  end
  
  def draw
    @cards = create_deck if @cards.empty?
    @cards.pop
  end
  
  private
  
  def create_deck
    cards = []
    RANKS.product(SUITS).each do |rank, suit|
      cards << Card.new(rank, suit)
    end
    
    cards.shuffle!
  end
end

class Card
  NON_NUMERIC_CARDS = { 
    'Jack' => 11, 'Queen' => 12,
    'King' => 13, 'Ace' => 14
  }
  
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def <=>(other_card)
    self_rank = self.relative_rank
    other_rank = other_card.relative_rank
    
    return 1 if self_rank > other_rank
    return -1 if self_rank < other_rank
    0
  end
  
  def ==(other_card)
    rank == other_card.rank && suit == other_card.suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
  
  protected
  
  def relative_rank
    return rank unless rank.to_i == 0
    NON_NUMERIC_CARDS[rank]
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.


=begin
Solution

# insert Card class from previous exercise here

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

Discussion

The initialization code for our Deck is in the #reset method of our class.
We put it here and not in #initialize since we need to periodically create
a new set of cards, and it's easier to do that in a separate method. Since
the method is not intended for public use (it could be though), we make it
private.

The #reset method works by combining the RANKS and SUITS Arrays with
Array#product, which produces an Array of nested 2-element Arrays. We
convert that to an Array of Card objects using #map.

The #draw method is relatively straightforward: we just call reset if
there are no more cards remaining, then we remove the topmost card from
the deck.

CONCEPTS
- use of array_a.product(array_b) to generate all combinations
- use shuffle to rearrange array

TO REVIEW
- use map instead of each to return result in a new array directly

=end