require_relative 'utilmod'
# frozen_string_literal: false

# This is parent player class of computer_player & human_player classes
class Player
  include UtilMod
  def initialize; end

  def validate_input(input)
    input.is_a?(Array) && input.length == 4 && input.all? { |ele| show_colors_utilmod.include?(ele) }
  end
end
