#!/usr/bin/env ruby

require_relative 'card'

class Hand

  HAND_RANK = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card
  ]

  def initialize(starting_cards)
    @cards = starting_cards
  end

  def cards
    @cards
  end

  def discard(cards)
    cards.each do |card|
      @cards.delete(card)
    end
  end

  def add(cards)
    @cards += cards
  end

  def stronger_than?(opponent)
    o_rank = HAND_RANK.index(opponent.rank_hand[0])
    my_rank = HAND_RANK.index(self.rank_hand[0])
    p [my_rank, o_rank]


    return -1 if o_rank[0] < my_rank[0]
    return 1 if o_rank[0] > my_rank[0]
    return 1 if my_rank[1] > o_rank[1]
    return -1 if my_rank[1] < o_rank[1]
    0
  end

  def rank_hand
    return [:straight_flush, straight_flush?] if straight_flush?
    return [:four_of_a_kind, four_of_a_kind?] if four_of_a_kind?
    return [:full_house, full_house?] if full_house?
    return [:flush, flush?] if flush?
    return [:straight, straight?] if straight?
    return [:three_of_a_kind, three_of_a_kind?] if three_of_a_kind?
    return [:two_pair, two_pair?] if two_pair?
    return [:one_pair, one_pair?] if one_pair?
    return [:high_card, high_card]
  end

  def high_card
    @cards.sort.last.rank
  end

  def counter
    counter = Hash.new(0)
    rank_array = @cards.map{|card| card.rank}
    rank_array.each { |r| counter[r] += 1 }
    counter
  end

  def one_pair?
    rank_hash = counter
    rank_hash.keep_if { |k,v| v == 2 }
    return false unless rank_hash.keys.length == 1
    rank_hash.keys[0]
  end

  def two_pair?
    rank_hash = counter
    rank_hash.keep_if{|k,v| v==2}
    return false unless rank_hash.keys.length == 2
    rank_hash.keys.sort
  end

  def four_of_a_kind?
    rank_hash = counter
    rank_hash.keep_if{|k,v| v==4}
    return false if rank_hash.empty?
    rank_hash.keys[0]
  end

  def three_of_a_kind?
    rank_hash = counter
    rank_hash.keep_if{|k,v| v==3}
    return false if rank_hash.empty?
    rank_hash.keys[0]
  end

  def full_house?
    rank_hash = counter
    return false unless rank_hash.any? {|k,v| v==3} && rank_hash.any? {|k,v| v==2}
    rank_hash.select{|k,v| v==3}.keys[0]
  end

  def straight_flush?
    return high_card if (flush? && straight?)
    false
  end

  def flush?
    return high_card if @cards.collect { |c| c.suit }.uniq.one?
    false
  end

  def straight?
    sorted_ranks = @cards.sort.collect {|c| c.rank}
    sorted_r = sorted_ranks.map{|r| r == 14 ? 1 : r }.sort
    return high_card if self.is_single_increment?(sorted_ranks) ||
              self.is_single_increment?(sorted_r)
    false
  end

  def is_single_increment?(sorted)
    prev_rank = sorted[0]
    (1...sorted.length).each do |index|
        return false if sorted[index] != prev_rank + 1
        prev_rank = sorted[index]
    end
    true
  end
end


#
# d6 = Card.new(:diamonds, 6)
# d5 = Card.new(:diamonds, 5)
# d4 = Card.new(:diamonds, 4)
# d3 = Card.new(:diamonds, 3)
# d2 = Card.new(:diamonds, 2)
#
# h = Hand.new([d2,d2,d3,d6,d4])
# count = h.pairs(h.cards.collect {|x| x.rank})
##
# # puts count.any? { |k,v| v == 3 }
# #
#
# straight_flush1 = Hand.new([dK,dQ,dJ,d10,d9])
# p straight_flush1.straight_flush?

dQ  = Card.new(:diamonds, 12)
dJ  = Card.new(:diamonds, 11)
d10 = Card.new(:diamonds, 10)
d9  = Card.new(:diamonds, 9)
d8  = Card.new(:diamonds, 8)

straight_flush2 = Hand.new([dQ,dJ,d10,d9,d8])
p straight_flush2.flush?
