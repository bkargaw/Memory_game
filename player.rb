class Player
  attr_accessor :name, :board_size

  def initialize()
    @name = get_name
  end

  def get_name
    puts "Give us a name"
    gets.chomp
  end

  def get_board_size
    puts "give us an even board size like \'2\'"
    begin
      pos = Integer(gets.chomp)
      raise 'error' if pos.odd?
    rescue
      puts "invalid grid_size"
      return get_board_size
    end
    @board_size = pos
  end

  def get_position
    puts "pick a position as \'1,1\'"
    begin
      pos = gets.chomp.split(',').map{|idx| Integer(idx)}
      raise 'error' if !pos.map {|el| (0...board_size).include?(el)}.all?
    rescue
      puts "invalid move"
      return get_position
    end

    pos
  end

  def receive_value(value, pos)

  end

end
