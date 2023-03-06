# frozen_string_literal: false

require_relative 'utilmod'

# This class is basicaly used to display data to the screen
class Board
  include UtilMod
  def initialize; end

  def display_creater_screen
    puts
    puts 'Computer is ready to guess...'
    puts 'Pick 4 colors with spaces between them...'
    print "Choose from: #{show_colors_utilmod}\n"
  end

  def display_breaker_screen
    puts
    puts 'Pick 4 colors with spaces between or q to quit'
    print "Choose from: #{show_colors_utilmod}\n"
  end

  def show_turn_output(humn_plyr_role, turn_result, guesses)
    puts "Corect Positions: #{turn_result[0]}"
    puts "Wrong Positions:  #{turn_result[1]}"
    puts
    puts "Guesses Left: #{guesses}\n"
    print "Choice      : #{show_colors_utilmod}\n"
    if humn_plyr_role == 'b'
      puts 'Enter Choice:  (q to quit)'
    else
      puts 'Computer Is Guessing...'
      sleep(1.2) # seconds
    end
  end

  def define_announce_result(humn_plyr_role, turn_result, inpt_sec_choice)
    puts
    if humn_plyr_role == 'b'
      anounce_result(%w[You Computer], humn_plyr_role, turn_result, inpt_sec_choice)
    else
      anounce_result(%w[Computer You], humn_plyr_role, turn_result, inpt_sec_choice)
    end
  end

  def anounce_result(word_arr, humn_plyr_role, turn_result, inpt_sec_choice)
    puts
    if turn_result[0] == 4
      puts "#{word_arr[0]} won!"
    else
      puts "#{word_arr[1]} Won!"
      return if humn_plyr_role == 'c'

      puts 'Correct guess was:'
      print "#{inpt_sec_choice}\n"
    end
  end

  def display_end_screen(secret_choice)
    puts
    puts 'You chose to end the game!' if secret_choice.to_s == 'q'
    puts 'Press Y to replay or N to quit from Program'
  end
end
