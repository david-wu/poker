#!/usr/bin/env ruby
# encoding: utf-8

# Represents a playing card.
class Card
  attr_reader :suit, :rank

  SUITS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  RANK = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  CARDS = {
     2  => "2",
     3  => "3",
     4  => "4",
     5  => "5",
     6  => "6",
     7  => "7",
     8  => "8",
     9  => "9",
     10 => "10",
     11 => "J",
     12 => "Q",
     13 => "K",
     14 => "A"
  }

  def initialize(suit, rank)
    @suit, @rank = suit, rank

  end

  def <=>(other)
    self.rank <=> other.rank
  end

end

