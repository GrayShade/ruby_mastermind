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
                :comptr_plyr_obj, :humn_logic_obj, :comptr_logic_obj

  def initialize
    
  end
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
    self.humn_logic_obj = CodeBreaker.new
    self.comptr_logic_obj = CodeCreator.new
  end

  def play_game()
    plyr_role = plyr_obj.select_role
    if plyr_role == 'c'
      board_obj.display_creater_screen
    else
      board_obj.display_breaker_screen
      inpt_secrt_choice = comptr_plyr_obj.inpt_secrt_choice
      while guesses >= 1
        humn_color_choice = humn_plyr_obj.input_color_choice
        
        turn_result = comptr_logic_obj.cater_cmputr_creatr(inpt_secrt_choice, humn_color_choice)
        # Use self for setter reassignment:
        self.guesses = guesses - 1
        process_result(plyr_role, turn_result, inpt_secrt_choice)
        # board_obj.show_turn_output()
      end
      
    end
    # display(plyr_role)
  end

  def process_result(plyr_role, turn_result, inpt_secrt_choice)
    if turn_result[0] == 4 || guesses.zero?
      board_obj.announce_result(plyr_role, turn_result, inpt_secrt_choice)
    else
      board_obj.show_turn_output(plyr_role, turn_result, guesses)
    end
  end

end

game_obj = Game.new
game_obj.start_game