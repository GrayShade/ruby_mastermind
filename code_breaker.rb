# frozen_string_literal: false

require_relative 'utilmod'
# this class defines Logic for human player
class CodeBreaker
  attr_accessor :first_found, :main_arr, :hints_arr, :counter, :colors_utilmod, :any_found_inc, :positions_arr,
                :skip_able_arr, :curent_choice, :corect_positn_arr, :wrong_positon_arr, :sure_presnt, :all_found

  include UtilMod
  def initialize
    self.positions_arr = []
    # self.any_found_inc = 0 # for the increments of arrays of same numbers till any number is found.
    # self.first_found = 0 # if this is 0, keep incrementing each turn with the incremental number
    self.skip_able_arr = []
    self.main_arr = Array.new(4, 0)
    # self.curent_choice = []
    self.colors_utilmod = show_colors_utilmod
    self.all_found = false
  end

  # def cater_humn_breakr(_humn_plyr_role, _color_choice)
  #   puts 'This is placeholder for human cater_breaker_logic'
  # end

  def cater_cmputr_breakr(humn_secrt_choice, guesses, turn_counter, sure_presnt)
    self.corect_positn_arr = []
    self.wrong_positon_arr = []
    self.hints_arr = []
    self.sure_presnt = sure_presnt
    print "sec choice: #{humn_secrt_choice}\n"
    if main_arr.all? { |ele| ele.to_s == '0' } # if main_array is empty yet
      self.main_arr = check_first_find(humn_secrt_choice, guesses, turn_counter)
    elsif main_arr.any? { |ele| ele.to_s != '0' } # if main_array is not empty
      self.main_arr = check_first_find(humn_secrt_choice, guesses, turn_counter)
    end
    # how to save result of main_arr while resetting it on each iteration
    # main_arr.each_with_index { |ele, idx| self.sure_presnt[idx] = ele if ele != '0' }
    print "main_arr: #{main_arr}\n"
    print "sure_presnt: #{sure_presnt}\n"
    print "skip_able_arr: #{skip_able_arr}\n"
    # self.main_arr = []
    # return [4, 0] if curent_choice == humn_secrt_choice
    hints_arr
  end

  def check_first_find(humn_secrt_choice, _guesses, turn_counter)
    # if there is no element found yet, take each color array from color module & check it
    #  against the computer choice. If not matches, take next & so. Also, mark that element as
    # skip_able for the future
    if main_arr.any? { |ele| ele.to_s == '0' }
      self.curent_choice = Array.new(4, colors_utilmod[turn_counter - 1]) # making array of a single element
    # if its first time after all found:
    elsif main_arr.none? { |ele| ele.to_s == '0' } && all_found == false
    #   # if its first time after having gotton 4 sure elements
      self.curent_choice = main_arr
      self.all_found = true
    
    #   skip_able_arr << 0 unless skip_able_arr.include?(0)
    else
      # if all eles found & its not first time after that, generate a
      # random one from them:
      sample = main_arr.sample(4)
      self.curent_choice = sample
      while skip_able_arr.include?(sample)
        sample = main_arr.sample(4)
        self.curent_choice = sample
      end
    end
    # so next time, no need for this exact combination.
    skip_able_arr << curent_choice unless skip_able_arr.include?(curent_choice)
    print "curent_choice: #{curent_choice}\n"
    self.hints_arr = check_positions(humn_secrt_choice, curent_choice) # checking matches
    print "hints_arr: #{hints_arr}\n"
    if hints_arr == [4, 0] && humn_secrt_choice == curent_choice # if all match
      main_arr.each_with_index { |ele, idx| main_arr[idx] = ele if curent_choice.include?(ele) }
      # print "all match: #{main_arr}"
      # self.first_found = 1
      print "main_arr: #{main_arr}\n"
    elsif hints_arr != [0, 0] # if any match found:
      found_positions_sum = hints_arr.sum
      humn_secrt_choice.each_with_index do |ele, idx|
        # print "main_arr: #{main_arr}\n"
        # replace all found ele's
        if sure_presnt.include?(ele) && curent_choice.include?(ele) && main_arr.include?(0)
          # as we need to replace zeros in ascending order:
          first_zero_index = main_arr.find_index(0) # find_index returns first found index
          main_arr[first_zero_index] = ele
          print "main_arr: #{main_arr}\n"
        end
        # fault above in elsif block
      end
      # print main_arr
      print "main_arr: #{main_arr}\n"
    elsif hints_arr == [0, 0] # if no match found
      # if no match found, put it in skip_able_arr. (redundent due to subsequent line???)
      curent_choice.each { |ele| skip_able_arr << ele unless skip_able_arr.include?(ele) }
      # Also remove from colors_utlimod so next hint does not include it:
      # self.colors_utilmod = colors_utilmod.select { |ele| true unless skip_able_arr.include?(ele) }
    end
    main_arr
  end

  def check_positions(humn_secrt_choice, curent_choice)
    final_arr = []
    # corect_positn_arr = []
    # wrong_positon_arr = []
    humn_secrt_choice.each_with_index do |ele, idx|
      curent_choice.each_with_index do |ele2, idx2|
        next unless ele == ele2 && idx == idx2

        corect_positn_arr[idx] = ele
        print "corect_positn_arr: #{corect_positn_arr}\n"
        sure_presnt << ele
        # wrong_positon_arr[idx] = ele if ele == ele2 && idx != idx2 && corect_positn_arr[idx] != ele
      end
    end
    humn_secrt_choice.each_with_index do |ele, idx|
      curent_choice.each_with_index do |ele2, idx2|
        # corect_positn_arr[idx] = ele if ele == ele2 && idx == idx2
        # it nneds to be checked seperately to not fill wrong position array in case these values are already in the correct position array:
        wrong_positon_arr[idx] = ele if ele == ele2 && idx != idx2 && corect_positn_arr[idx] != ele
      end
    end
    corect_positn_length = corect_positn_arr.count { |ele| !ele.nil? }
    wrong_positn_length = wrong_positon_arr.count { |ele| !ele.nil? }
    self.hints_arr = [corect_positn_length, wrong_positn_length]
  end
end
