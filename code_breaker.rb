# frozen_string_literal: false

require_relative 'utilmod'
# this class defines Logic for human player
class CodeBreaker
  attr_accessor :main_arr, :hints_arr, :colors_utilmod, :skip_positn_hash, :skip_arr,
                :curent_choice, :corect_positn_arr, :wrong_positon_arr, :sure_presnt, :all_found

  include UtilMod
  def initialize
    self.skip_positn_hash = Hash.new([])
    self.skip_arr = []
    self.main_arr = Array.new(4, 0)
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
    print "skip_arr: #{skip_arr}\n"
    # self.main_arr = []
    # return [4, 0] if curent_choice == humn_secrt_choice
    hints_arr
  end

  def check_first_find(humn_secrt_choice, _guesses, _turn_counter)
    # if there is no element found yet, take each color array from color module & check it
    #  against the computer choice. If not matches, take next & so. Also, mark that element as
    # skip_able for the future
    if main_arr.any? { |ele| ele.to_s == '0' }
      # sample_ele = create_sample_arr(colors_utilmod, 1)
      sample_ele = colors_utilmod.sample(1)[0] # 0 is used here to get ele instead of [ele]
      sample_ele = colors_utilmod.sample(1)[0] while skip_arr.include?(sample_ele)
      # self.curent_choice = Array.new(4, colors_utilmod[turn_counter - 1]) # making array of a single element
      self.curent_choice = Array.new(4, sample_ele)
      skip_arr << sample_ele unless skip_arr.include?(sample_ele)
    # if its first time after all found:
    elsif main_arr.none? { |ele| ele.to_s == '0' } && all_found == false
      #   # if its first time after having gotton 4 sure elements
      self.curent_choice = main_arr
      self.all_found = true

    #   skip_arr << 0 unless skip_arr.include?(0)
    else
      # if all eles found & its not first time after that, generate a
      # random one from them:

      sample_arr = main_arr.sample(4)
      while skip_arr.include?(sample_arr) || check_skip_positions?(sample_arr) == false
        # sample_arr.each_with_index do |ele, idx|
        # is_skip_able_positn = check_skip_positions?
        # print "position is: #{is_skip_able_positn}\n"
        # end
        sample_arr = main_arr.sample(4)
      end
      self.curent_choice = sample_arr
    end
    # so next time, no need for this exact combination.
    skip_arr << curent_choice unless skip_arr.include?(curent_choice)
    print "curent_choice: #{curent_choice}\n"
    self.hints_arr = check_positions(humn_secrt_choice, curent_choice) # checking matches
    print "hints_arr: #{hints_arr}\n"
    if hints_arr == [4, 0] && humn_secrt_choice == curent_choice # if all match
      main_arr.each_with_index { |ele, idx| main_arr[idx] = ele if curent_choice.include?(ele) }
      # print "all match: #{main_arr}"
      # self.first_found = 1
      print "main_arr: #{main_arr}\n"
    elsif hints_arr != [0, 0] # if any match found:

      if hints_arr == [0, 4] # if all matrches are on wrong positions
        curent_choice.each_with_index do |ele, idx|
          self.skip_positn_hash[idx] += [ele] unless skip_positn_hash[idx].include?(ele)
        end
      end
      humn_secrt_choice.each_with_index do |ele, _idx|
        # replace all found ele's
        next unless sure_presnt.include?(ele) && curent_choice.include?(ele) && main_arr.include?(0)

        # as we need to replace zeros with founf ele in ascending order so that computer
        #   player knows which eles are found but not their actual position:
        first_zero_index = main_arr.find_index(0) # find_index returns first found index
        main_arr[first_zero_index] = ele
        print "main_arr: #{main_arr}\n"
      end
      print "main_arr: #{main_arr}\n"
      print "skip_position_hash: #{skip_positn_hash}\n"
    elsif hints_arr == [0, 0] # if no match found
      # if no match found, put it in skip_arr. (redundent due to subsequent line???)
      curent_choice.each { |ele| skip_arr << ele unless skip_arr.include?(ele) }
      # Also remove from colors_utlimod so next hint does not include it:
      # self.colors_utilmod = colors_utilmod.select { |ele| true unless skip_arr.include?(ele) }
    end
    main_arr
  end

  def check_skip_positions?(sample_arr)
    skip_positn_hash.each do |k, v|
      sample_arr.each_with_index do |ele, idx|
         print "#{sample_arr} should be skipped \n" if skip_positn_hash[k].include?(ele) && idx == k
        return false if skip_positn_hash[k].include?(ele) && idx == k
      end
    end
    true
  end

  def check_positions(humn_secrt_choice, curent_choice) # for hints arr basically
    # final_arr = []

    humn_secrt_choice.each_with_index do |ele, idx|
      curent_choice.each_with_index do |ele2, idx2|
        next unless ele == ele2 && idx == idx2

        corect_positn_arr[idx] = ele
        print "corect_positn_arr: #{corect_positn_arr}\n"
        sure_presnt << ele unless sure_presnt.include?(ele)
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
    if hints_arr == [0, 4]
      hints_arr
    end
    hints_arr
  end
end
