# frozen_string_literal: false

require_relative 'board'
require_relative 'player'
require_relative 'computer_player'
require_relative 'human_player'
require_relative 'code_breaker'
require_relative 'code_creater'

# This is intended to be a class, for now atleast
class Game
  attr_accessor :guesses, :board_obj, :plyr_obj, :humn_plyr_obj,
                :comptr_plyr_obj, :breaker_logic_obj, :creater_logic_obj

  def initialize; end
  # include Board

  def start_game
    puts 'Welcome to the Mastermind game...'
    puts 'This will truly test your wits to the edge...'
    self.guesses = 2
    create_objects
    play_game
  end

  def create_objects
    self.board_obj = Board.new
    self.plyr_obj = Player.new
    self.humn_plyr_obj = HumanPlayer.new
    self.comptr_plyr_obj = ComputerPlayer.new
    self.breaker_logic_obj = CodeBreaker.new
    self.creater_logic_obj = CodeCreator.new
  end

  def play_game
    humn_plyr_role = humn_plyr_obj.select_role
    if humn_plyr_role == 'c'
      board_obj.display_creater_screen
      humn_secrt_choice = humn_plyr_obj.inpt_choice
      while guesses >= 1
        comptr_color_choice = comptr_plyr_obj.inpt_secrt_choice
        turn_result = breaker_logic_obj.cater_cmputr_breakr(humn_secrt_choice, comptr_color_choice)
        # Use self for setter reassignment:
        self.guesses = guesses - 1
        process_result(humn_plyr_role, turn_result, humn_secrt_choice)
        # board_obj.show_turn_output()
      end
    else
      board_obj.display_breaker_screen
      comptr_secrt_choice = comptr_plyr_obj.inpt_secrt_choice
      while guesses >= 1
        humn_turn_choice = humn_plyr_obj.inpt_choice
        turn_result = creater_logic_obj.cater_cmputr_creatr(comptr_secrt_choice, humn_turn_choice)
        # Use self for setter reassignment:
        self.guesses = guesses - 1
        process_result(humn_plyr_role, turn_result, comptr_secrt_choice)
        # board_obj.show_turn_output()
      end

    end
    # display(humn_plyr_role)
  end

  def process_result(humn_plyr_role, turn_result, inpt_secrt_choice)
    if turn_result[0] == 4 || guesses.zero?
      board_obj.announce_result(humn_plyr_role, turn_result, inpt_secrt_choice)
    else
      board_obj.show_turn_output(humn_plyr_role, turn_result, guesses)
    end
  end
end

game_obj = Game.new
game_obj.start_game
