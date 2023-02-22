# frozen_string_literal: false

require_relative 'player'
# This is intended to be a class
class HumanPlayer < Player
  def initialize
    super
  end

  def select_role
    puts 'Do you want to be the creator(c) of secret code or the breaker(b)?'
    role = gets.chomp.strip.downcase
    until %w[c b].include?(role)
      puts 'Wrong Choice !!!'
      role = gets.chomp
    end
    role
  end

  def inpt_choice
    input = gets.chomp.strip.downcase
    return input if input.to_s == 'q'

    input = input.split(' ')
    until validate_input(input) == true
      puts
      puts "Wrong Choice!!! \nPick Again:  (q to quit)"
      input = gets.chomp.strip.downcase
      return input if input.to_s == 'q'

      input = input.split(' ')
      validate_input(input)
    end
    input
  end

  def end_game_input
    input = gets.chomp.strip.downcase
    until %w[y n].include?(input)
      puts
      puts "Wrong Choice!!! \nPick Again:"
      input = gets.chomp.strip.downcase
    end
    input
  end

  # def inpt_secrt_choice
  #   input = gets.chomp.strip.downcase.split(' ')
  #   until validate_input(input) == true
  #     puts
  #     puts "Wrong Choice!!! \nPick Again:"
  #     input = gets.chomp.strip.downcase.split(' ')
  #     validate_input(input)
  #   end
  #   input
  # end
end
