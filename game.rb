# frozen_string_literal: false

require_relative 'board'
require_relative 'player'
require_relative 'computer_player'
require_relative 'human_player'
require_relative 'code_breaker'
require_relative 'code_creater'

# This is main class which is used to start game & accesses many other classes
# via objects
class Game
  attr_accessor :guesses, :board_obj, :plyr_obj, :humn_plyr_obj,
                :comptr_plyr_obj, :breaker_logic_obj, :creater_logic_obj

  def initialize; end

  def start_game
    puts 'Welcome to the Mastermind game...'
    puts 'This will truly test your wits to the edge...'
    self.guesses = 12
    play_game
  end

  private

  # private begin block:
  begin
    def play_game
      puts 'Game Begins...'
      create_objects
      humn_plyr_role = humn_plyr_obj.select_role
      humn_plyr_role == 'c' ? proces_creatr_role(humn_plyr_role) : proces_breakr_role(humn_plyr_role)
    end

    def create_objects
      self.board_obj = Board.new
      self.plyr_obj = Player.new
      self.humn_plyr_obj = HumanPlayer.new
      self.comptr_plyr_obj = ComputerPlayer.new
      self.breaker_logic_obj = CodeBreaker.new
      self.creater_logic_obj = CodeCreator.new
    end

    def proces_creatr_role(humn_plyr_role)
      board_obj.display_creater_screen
      humn_secrt_choice = humn_plyr_obj.inpt_choice
      # humn_secrt_choice = %w[r g o c]
      if humn_secrt_choice == 'q'
        end_game(humn_secrt_choice)
        # return or lines after end_game function will start execution after
        # end_game sub functions completion:
        return
      end
      turn_counter = 1
      while guesses >= 1
        turn_result = breaker_logic_obj.cater_cmputr_breakr(humn_secrt_choice, turn_counter)
        turn_counter += 1
        # Use self for setter assignment or reassignment:
        self.guesses = guesses - 1
        process_result(humn_plyr_role, turn_result, humn_secrt_choice)
      end
    end

    def proces_breakr_role(humn_plyr_role)
      board_obj.display_breaker_screen
      comptr_secrt_choice = comptr_plyr_obj.inpt_choice
      while guesses >= 1
        humn_turn_choice = humn_plyr_obj.inpt_choice
        if humn_turn_choice == 'q'
          end_game(humn_turn_choice)
          # return or lines after end_game function will start execution after
          # end_game sub functions completion:
          return
        end
        turn_result = creater_logic_obj.cater_cmputr_creatr(comptr_secrt_choice, humn_turn_choice)
        # Use self for setter assignment or reassignment:
        self.guesses = guesses - 1
        process_result(humn_plyr_role, turn_result, comptr_secrt_choice)
      end
    end

    def process_result(humn_plyr_role, turn_result, comptr_secrt_choice)
      if turn_result[0] == 4 || guesses.zero?
        board_obj.define_announce_result(humn_plyr_role, turn_result, comptr_secrt_choice)
        end_game(comptr_secrt_choice)
      else
        board_obj.show_turn_output(humn_plyr_role, turn_result, guesses)
      end
    end

    def end_game(secret_choice)
      board_obj.display_end_screen(secret_choice)
      input = humn_plyr_obj.end_game_input
      if input == 'y'
        self.guesses = 12
        play_game
      else
        puts 'Game Exits...'
        exit
      end
    end
  end
end

game_obj = Game.new
game_obj.start_game
