require_relative 'card.rb'
class Board

  def initialize(grid_size = 6)
    @grid = Array.new(grid_size){Array.new(grid_size)}
    populate
  end

  def populate
    num_elem = (grid.length**2) / 2
    place_cards(generate_elements(num_elem))
  end

  def generate_elements(num_elem)
    elements = []
    while elements.length < num_elem
      rand_num = rand(0..num_elem**4)
      elements << rand_num if !(elements.include?(rand_num))
    end

    elements
  end

  def place_cards(card_values)
    card_values = (card_values * 2).shuffle
    card_idx = 0
    (0...grid.length).each do |i|
      (0...grid.length).each do |j|
        self[[i,j]]= Card.new(card_values[card_idx])
        card_idx += 1
      end
    end
  end

  def []= pos, value
    row, col = pos
    @grid[row][col] = value
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def render
    grid.each do |row|
      puts row.map {|el| el.to_s}.inspect
    end
  end

  def game_over?
    grid.each do |row|
      row.each do |pos|
        return false if !pos.face_up
      end
    end
    true
  end

  def reveal(pos)
    self[pos].reveal
    self[pos].value
  end

  def hide(pos)
    self[pos].hide
  end

  private

  attr_accessor :grid

end
