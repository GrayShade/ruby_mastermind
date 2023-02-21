# frozen_string_literal: false
require_relative 'player'
require_relative 'utilmod'
# This is intended to be a class
class ComputerPlayer < Player
  include UtilMod
  def initialize; end

  def inpt_secrt_choice
    sec_choice = show_colors_utilmod.sample(4)
  end
end