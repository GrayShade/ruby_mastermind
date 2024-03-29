# frozen_string_literal: false

require_relative 'player'
require_relative 'utilmod'
# This is computer player class inherited from Player Class
class ComputerPlayer < Player
  include UtilMod

  def inpt_choice
    input = show_colors_utilmod.sample(4)
    # there was no need for validating computer input below, but utilized it to
    #  just use inheritence from parent in this particular project.
    until validate_input(input) == true
      puts
      puts "Wrong Choice!!! \nPick Again:"
      input = show_colors_utilmod.sample(4)
      validate_input(input)
    end
    input
  end
end
