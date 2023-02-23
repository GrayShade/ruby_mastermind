# frozen_string_literal: false

require_relative 'utilmod'
# this class defines Logic for human player
class CodeBreaker
  attr_accessor :first_found, :main_arr, :hints_arr, :counter, :colors_utilmod, :any_found_inc, :positions_arr,
                :skip_able_nums_arr, :current_arr, :corect_positn_arr, :wrong_positon_arr, :final_arr

  include UtilMod
  def initialize
    self.positions_arr = []
    # self.any_found_inc = 0 # for the increments of arrays of same numbers till any number is found.
    # self.first_found = 0 # if this is 0, keep incrementing each turn with the incremental number
    self.skip_able_nums_arr = []
    self.main_arr = Array.new(4, 0)
    # self.current_arr = []
    self.colors_utilmod = show_colors_utilmod
  end

  # def cater_humn_breakr(_humn_plyr_role, _color_choice)
  #   puts 'This is placeholder for human cater_breaker_logic'
  # end

  def cater_cmputr_breakr(humn_secrt_choice, guesses, turn_counter, final_arr)
    self.corect_positn_arr = []
    self.wrong_positon_arr = []
    self.hints_arr = []
    if main_arr.all? { |ele| ele.to_s == '0' } # if main_array is empty yet
      self.main_arr = check_first_find(humn_secrt_choice, guesses, turn_counter)
      p main_arr
    elsif main_arr.any? { |ele| ele.to_s != '0' } # if main_array is not empty

    end
    # how to save result of main_arr while resetting it on each iteration
    self.main_arr = final_arr
    self.main_arr = []
    self.hints_arr = [corect_positn_arr.length, wrong_positon_arr.length]
  end

  def check_first_find(humn_secrt_choice, _guesses, turn_counter)
    # if there is no element found yet, take each color array from color module & check it
    #  against the computer choice. If not matches, take next & so. Also, mark that element as
    # skip_able for the future
    self.current_arr = Array.new(4, colors_utilmod[turn_counter - 1]) # making array of a single element

    p "current_arr: #{current_arr}"
    self.hints_arr = check_positions(humn_secrt_choice, current_arr) # checking matches
    if hints_arr == [4, 0] # if all match
      main_arr.each_with_index { |_ele, idx| main_arr[idx] = current_arr[0] }
      # print "all match: #{main_arr}"
      # self.first_found = 1
      main_arr
    elsif hints_arr != [0, 0] # if any match found:
      found_positions_sum = hints_arr.sum
      main_arr.each_with_index do |_ele, idx|
        self.main_arr[idx] = current_arr[0] if found_positions_sum - 1 <= idx # replace all found ele's
        # self.first_found = 1
      end
      main_arr
    elsif hints_arr == [0, 0] # if no match found
      skip_able_nums_arr << current_arr[0]
    end
    main_arr
  end

  def check_positions(humn_secrt_choice, arr_to_check)
    final_arr = []
    # corect_positn_arr = []
    # wrong_positon_arr = []
    humn_secrt_choice.each_with_index do |ele, idx|
      arr_to_check.each_with_index do |ele2, idx2|
        corect_positn_arr[idx] = ele if ele == ele2 && idx == idx2
        # wrong_positon_arr[idx] = ele if ele == ele2 && idx != idx2 && corect_positn_arr[idx] != ele
      end
    end
    humn_secrt_choice.each_with_index do |ele, idx|
      arr_to_check.each_with_index do |ele2, idx2|
        # corect_positn_arr[idx] = ele if ele == ele2 && idx == idx2
        # it nneds to be checked seperately to not fill wrong position array in case these values are already in the correct position array:
        wrong_positon_arr[idx] = ele if ele == ele2 && idx != idx2 && corect_positn_arr[idx] != ele
      end
    end
    self.hints_arr = [corect_positn_arr.length, wrong_positon_arr.length]
  end
end
