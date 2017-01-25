require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'computer_player.rb'

class Game

  def initialize(player, board)
    @player = player
    @board = board
    @previous_guess = nil
  end

  def run
    render
    while !board.game_over?
      run_turn
    end

    puts "yay #{player.name} you win!"
  end

  def run_turn
    guess_position = get_guess
    if previous_guess
      value = act_on_second_guess(guess_position)
      player.receive_value(value, guess_position)
      value
    else
      @previous_guess = guess_position
      value = board.reveal(previous_guess)
      render
      player.receive_value(value, previous_guess)
      value
    end
  end

  def get_guess
    guess_position = player.get_position
    if guess_position == previous_guess
      get_guess
    end

    guess_position
  end

  def act_on_second_guess(guess_position)
    value = board.reveal(guess_position)
    if board[guess_position] == board[previous_guess]
      render
    else
      render
      sleep(2)
      system("clear")
      hide_cards(guess_position)
    end

    @previous_guess = nil
    value
  end

  def hide_cards(guess_position)
    board.hide(guess_position)
    board.hide(previous_guess)
  end

  def render
    puts "the board looks like this"
    board.render
  end

  private
  attr_accessor :board, :player, :previous_guess
end

if __FILE__ == $PROGRAM_NAME
  # player = Player.new
  player = ComputerPlayer.new
  my_board = Board.new(player.get_board_size)
  game = Game.new(player, my_board)
  game.run
end
