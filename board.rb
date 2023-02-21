require_relative 'utilmod'
# frozen_string_literal: false

# This is intended to be a module as there will be only methods or will be?
class Board
  include UtilMod
  # attr_reader :guesses
  def initialize
    # guesses = 12
  end

  def display_creater_screen
    puts 'placeholder for creater screen'
  end

  def display_breaker_screen
    puts
    puts 'Pick 4 colors with spaces between them...'
    # puts 'You can also type first letters of colors with spaces only...'
    print "Choose from: #{show_colors_utilmod}\n"
  end

  def show_turn_output(plyr_role, turn_result, guesses)
    # puts 'This is a placeholder for show_turn_output method'
    return unless plyr_role == 'b'

    puts "Corect Positions: #{turn_result[0]}"
    puts "Wrong Positions:  #{turn_result[1]}"
    puts
    puts "Guesses Left: #{guesses}\n"
    print "Choose from:  #{show_colors_utilmod}\n"
    puts 'Pick Again:'
  end

  def announce_result(plyr_role, turn_result, inpt_secrt_choice)
    puts
    if turn_result[0] == 4 && plyr_role == 'b'
      puts 'you win!'
    else
      puts 'You lost! Computer Wins'
      puts 'Correct guess was:'
      print "#{inpt_secrt_choice}\n"
    end
  end
end
