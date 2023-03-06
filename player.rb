# frozen_string_literal: false

require_relative 'utilmod'
# This is parent player class of ComputerPlayer & HumanPlayer classes
class Player
  include UtilMod
  def initialize; end

  private

  def validate_input(input)
    input.is_a?(Array) && input.length == 4 && input.all? { |ele| show_colors_utilmod.include?(ele) }
  end
end
