
require 'rspec'
require 'poker'
require 'card'
require 'hand'

# describe Poker do
#
#   describe '#pot' do
#   end
#
#   describe '#players' do
#     #store players
#   end
#
#   describe '#add_player(p)' do
#   end
#
#   describe '#remove_players(p)' do
#   end
#
#   describe '#game_over?' do
#   end
#
# end

# describe Deck do
#   describe "#cards" do
#     # it should "return deck contents"
#     # expect(deck.cards.length).to eq(52)
#   end
#
#   describe '#shuffle' do
#
#   end
#
#   describe '#deal(n)' do
#   end
#
#   describe '#initialize' do
#   end
#
#
# end
#
#

describe Card do
  subject(:card) { Card.new(:spades, 14) }

  describe '#suit' do
    it "should return suit" do
      expect(card.suit).to eq(:spades)
    end
  end

  describe '#rank' do
    it "should return rank" do
      expect(card.rank).to eq(14)
    end
  end

  describe '#initialize(suit,rank)' do
    it "should initialize" do
      expect(Card.new(:spades, 14).class).to eq(card.class)
    end
  end
end


describe Hand do
  let(:sA) { Card.new(:spades, 14) }
  let(:hA) { Card.new(:hearts, 14) }
  let(:dA) { Card.new(:diamonds, 14) }
  let(:cA) { Card.new(:clubs, 14) }

  let(:dK) { Card.new(:diamonds, 13) }
  let(:dQ) { Card.new(:diamonds, 12) }
  let(:dJ) { Card.new(:diamonds, 11) }
  let(:d10) { Card.new(:diamonds, 10) }
  let(:d9) { Card.new(:diamonds, 9) }
  let(:d8) { Card.new(:diamonds, 8) }
  let(:d7) { Card.new(:diamonds, 7) }
  let(:d6) { Card.new(:diamonds, 6) }
  let(:d5) { Card.new(:diamonds, 5) }
  let(:d4) { Card.new(:diamonds, 4) }
  let(:d3) { Card.new(:diamonds, 3) }
  let(:d2) { Card.new(:diamonds, 2) }

  let(:hK) { Card.new(:hearts, 13) }
  let(:hQ) { Card.new(:hearts, 12) }
  let(:hJ) { Card.new(:hearts, 11) }
  let(:h10) { Card.new(:hearts, 10) }
  let(:h9) { Card.new(:hearts, 9) }
  let(:h8) { Card.new(:hearts, 8) }
  let(:h7) { Card.new(:hearts, 7) }
  let(:h6) { Card.new(:hearts, 6) }
  let(:h5) { Card.new(:hearts, 5) }
  let(:h4) { Card.new(:hearts, 4) }
  let(:h3) { Card.new(:hearts, 3) }
  let(:h2) { Card.new(:hearts, 2) }

  let(:cK) { Card.new(:clubs, 13) }
  let(:cQ) { Card.new(:clubs, 12) }
  let(:cJ) { Card.new(:clubs, 11) }
  let(:c10) { Card.new(:clubs, 10) }
  let(:c9) { Card.new(:clubs, 9) }
  let(:c8) { Card.new(:clubs, 8) }
  let(:c7) { Card.new(:clubs, 7) }
  let(:c6) { Card.new(:clubs, 6) }
  let(:c5) { Card.new(:clubs, 5) }
  let(:c4) { Card.new(:clubs, 4) }
  let(:c3) { Card.new(:clubs, 3) }
  let(:c2) { Card.new(:clubs, 2) }

  let(:sK) { Card.new(:spades, 13) }
  let(:sQ) { Card.new(:spades, 12) }
  let(:sJ) { Card.new(:spades, 11) }
  let(:s10) { Card.new(:spades, 10) }
  let(:s9) { Card.new(:spades, 9) }
  let(:s8) { Card.new(:spades, 8) }
  let(:s7) { Card.new(:spades, 7) }
  let(:s6) { Card.new(:spades, 6) }
  let(:s5) { Card.new(:spades, 5) }
  let(:s4) { Card.new(:spades, 4) }
  let(:s3) { Card.new(:spades, 3) }
  let(:s2) { Card.new(:spades, 2) }

  subject(:hand) { Hand.new([sA, hA, dA, cA]) }

  describe '#cards' do
    it "should list cards" do
      expect(hand.cards).to eq([sA, hA, dA, cA])
    end
  end


  describe '#initialize([starting_cards])' do
    it "should hold the cards" do
      hand = Hand.new([sA])
      expect(hand.cards).to eq([sA])
    end
  end

  describe '#discard([cards])' do
    it "should discard cards" do
      hand.discard([sA,hA])
      expect(hand.cards).to eq([dA,cA])
    end
  end

  describe '#add_cards([cards])' do
    it "should add cards" do
      hand.add([dK,dQ])
      expect(hand.cards).to eq([sA, hA, dA, cA,dK,dQ])
    end
  end

  describe '#counter' do
    it 'should return hash of counts' do
      hand = Hand.new([dA,d2,d3,h4,d3])
      expect(hand.counter).to eq({14=>1, 2=>1, 3=>2, 4=>1})
    end
  end

  describe '#full_house' do
    it 'should return true if full house' do
      hand = Hand.new([dA,hA,cA,h10,d10])
      expect(hand.full_house?).to be(14)
    end

    it 'should return false if not full house' do
      hand = Hand.new([dA,hA,cA,h10,d3])
      expect(hand.full_house?).to be(false)
    end
  end

  describe '#is_straight?' do
    it 'should be a straight' do
      straight = Hand.new([dK,dQ,dJ,h10,dA])
      expect(straight.straight?).to be(14)
    end

    it 'should be a straight' do
      straight = Hand.new([dA,dK,dQ,dJ,h4])
      expect(straight.straight?).to be(false)
    end

    it 'should be a straight' do
      straight = Hand.new([dA,d2,d3,h4,d5])
      expect(straight.straight?).to be(14)
    end
  end

  describe '#is_flush?' do
    it 'should be a flush if its a goddamn flush' do
      flush = Hand.new([dA, d7, d5, dQ, d9])
      expect(flush.flush?).to be(14)
    end

    it 'should be a flush if its a goddamn flush' do
      flush = Hand.new([sA, d7, d5, dQ, d9])
      expect(flush.flush?).to be(false)
    end
  end

  describe '#two_pair?' do
    it 'should return array if two pair' do
      two_pair = Hand.new([sA, hA, d10, h10, d9])
      expect(two_pair.two_pair?).to eq([10,14])
    end
    it 'should return false if not two pair' do
      two_pair = Hand.new([sA, d2, d10, h10, d9])
      expect(two_pair.two_pair?).to eq(false)
    end
  end

  describe '#one_pair?' do
    it 'should return array if one pair' do
      one_pair = Hand.new([sA, h4, d10, h10, d9])
      expect(one_pair.one_pair?).to eq(10)
    end
    it 'should return false if not one pair' do
      one_pair = Hand.new([sA, d2, d5, h10, d9])
      expect(one_pair.one_pair?).to eq(false)
    end
  end

  describe '#four_of_a_kind?' do
    it 'should return value if 4 of a kind' do
      four_kind = Hand.new([sA, hA, cA, dA, d9])
      expect(four_kind.four_of_a_kind?).to eq(14)
    end
    it 'should return false if 4 of a kind' do
      four_kind = Hand.new([sA, d2, d9, h10, d9])
      expect(four_kind.four_of_a_kind?).to eq(false)
    end
  end

  describe '#straight_flush' do
    it 'should be a straight_flush' do
      straight_flush = Hand.new([dK,dQ,dJ,d10,d9])
      expect(straight_flush.straight_flush?).to be(13)
    end

    it 'should also be a straight flush' do
      straight_flush = Hand.new([dQ,dJ,d10,d9,d8])
      expect(straight_flush.straight_flush?).to be(12)
    end
  end

  describe '#stronger_than?(hand)' do

    it "straight flush beats 4 of a kind" do
      straight_flush = Hand.new([dA,dK,dQ,dJ,d10])
      four_As = Hand.new([sA, hA, dA, cA, d10])
      expect(four_As.stronger_than?(straight_flush)).to be(-1)
      expect(straight_flush.stronger_than?(four_As)).to be(1)
    end

    it "straight flush with higher card should win" do
      straight_flush1 = Hand.new([dK,dQ,dJ,d10,d9])
      straight_flush2 = Hand.new([dQ,dJ,d10,d9,d8])
      expect(straight_flush1.stronger_than?(straight_flush2)).to be(1)
      expect(straight_flush2.stronger_than?(straight_flush1)).to be(-1)
    end

    it "straight flush with tie should be a tie" do
      straight_flush1 = Hand.new([dA,dK,dQ,dJ,d10])
      straight_flush2 = Hand.new([sA,sK,sQ,sJ,s10])
      expect(straight_flush1.stronger_than?(straight_flush2)).to be(0)
      expect(straight_flush2.stronger_than?(straight_flush1)).to be(0)
    end
  end

end

#
# describe Player do
#
#   describe '#hand' do
#   end
#
#   describe '#turn' do
#   end
    # describe '#bet' do
    # end
#
#   describe '#bank' do
#
#   end
#
# end