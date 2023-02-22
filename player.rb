require_relative 'utilmod'
# frozen_string_literal: false

# This is parent player class of computer_player & human_player classes
class Player
  include UtilMod
  def initialize; end

  # def select_role
  #   puts 'Do you want to be the creator(c) of secret code or the breaker(b)?'
  #   role = gets.chomp.strip.downcase
  #   until %w[c b].include?(role)
  #     puts 'Wrong Choice !!!'
  #     role = gets.chomp
  #   end
  #   role
  # end

  def validate_input(input)
    # return true if input.to_s.downcase == 'q'
    # input = input.split(' ')
    input.is_a?(Array) && input.length == 4 && input.uniq.length == 4 && input.all? { |ele| show_colors_utilmod.include?(ele) }
  end
end
