require_relative 'player.rb'
require 'set'


require 'byebug'
class ComputerPlayer < Player

  def initialize
    super
    @seen_values = Hash.new {|h,k| h[k] = []}
    @past_guessed_pos = Set.new
    @turn_num = 1
    @past_guessed_value = nil
  end

  def get_name
    "AI"
  end

  def get_board_size
    @board_size = rand(2..6)
    board_size.odd? ? get_board_size : board_size
  end

  def get_position
    if turn_num == 1
      pos = first_turn_move
      @turn_num = 2
    else
      pos = second_turn_move
      @turn_num = 1
    end
    pos
  end

  def receive_value(value, pos)
    @seen_values[value] << pos if !seen_values[value].include?(pos)
  end

  def first_turn_move

    possible_value = find_possible_value
    if possible_value
      @past_guessed_value = possible_value
      pos = seen_values[past_guessed_value][0]
      @past_guessed_pos << pos
    else
      pos = guess_random
    end
    pos
  end

  def find_possible_value
    seen_values.each_value do |value|
      return seen_values.key(value) if (value.length == 2 && !position_in_our_set(value))
    end
    nil
  end

  def second_turn_move
    if past_guessed_value
      pos = seen_values[past_guessed_value][1]
      @past_guessed_pos << pos
      @past_guessed_value = nil
    else
      pos = guess_random

    end

    pos
  end

  def guess_random
    possible_positions = get_possible_positions
    possible_positions[rand(0...possible_positions.length)]
  end

  def get_possible_positions
    possible_positions = []
    (0...board_size).each do |i|
      (0...board_size).each do |j|
        possible_positions << [i,j] if position_in_our_hash(i, j)
      end
    end
    possible_positions
  end

  def position_in_our_hash(i, j)
    seen_values.values.each do |value|
      return false if value.include?([i,j])
    end
    true
  end

  def position_in_our_set(pos_array)
    pos_array.each do |pos|
      return true if past_guessed_pos.include?(pos)
    end
    false
  end


  private
  attr_accessor :seen_values, :past_guessed_value, :turn_num, :board_size, :past_guessed_pos
end
