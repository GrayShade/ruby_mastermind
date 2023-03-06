# frozen_string_literal: false

require_relative 'utilmod'
# this class defines Logic for computer player as breaker
class CodeBreaker
  attr_accessor :main_arr, :hints_arr, :colors_utilmod, :skip_positn_hash, :skip_arr,
                :comptr_turn_choice, :sure_presnt, :all_found

  include UtilMod
  def initialize
    self.skip_positn_hash = Hash.new([])
    self.skip_arr = []
    self.main_arr = Array.new(4, 0)
    self.colors_utilmod = show_colors_utilmod
    self.all_found = false
    self.sure_presnt = [] # all elements which are
  end

  def cater_cmputr_breakr(humn_secrt_choice, _turn_counter)
    self.hints_arr = []

    if main_arr.all? { |ele| ele.to_s == '0' } # if main_array is empty yet
      self.comptr_turn_choice = insert_elements
    elsif main_arr.any? { |ele| ele.to_s != '0' } # if main_array is not empty
      self.comptr_turn_choice = insert_elements
    end

    skip_arr << comptr_turn_choice unless skip_arr.include?(comptr_turn_choice)
    print "comptr_turn_choice: #{comptr_turn_choice}\n"
    self.hints_arr = create_hints_array(humn_secrt_choice, comptr_turn_choice) # checking matches
    print "hints_arr: #{hints_arr}\n"
    if hints_arr == [4, 0] && humn_secrt_choice == comptr_turn_choice # if all elements match
      cater_if_all_match
    elsif hints_arr != [0, 0] # if any element match
      cater_if_any_match(humn_secrt_choice)
    elsif hints_arr == [0, 0] # if no match found
      cater_if_no_match
    end
    hints_arr
  end

  private

  #  private block starts:
  begin
    def insert_elements
      # if there is no element found yet, take each color array from color module & check it
      #  against the computer choice. If not matches, take next & so. Also, mark that element as
      # skip_able for the future to not include it.
      if main_arr.any? { |ele| ele.to_s == '0' }
        sample_ele = colors_utilmod.sample(1)[0] # 0 is used here to get ele instead of [ele]
        sample_ele = colors_utilmod.sample(1)[0] while skip_arr.include?(sample_ele)
        self.comptr_turn_choice = Array.new(4, sample_ele)
        skip_arr << sample_ele unless skip_arr.include?(sample_ele)
      # if its first time after all found:
      elsif main_arr.none? { |ele| ele.to_s == '0' } && all_found == false
        #   # if its first time after having gotton 4 sure elements
        self.comptr_turn_choice = main_arr
        self.all_found = true
      else
        # print "skip_positn_hash: #{skip_positn_hash}\n"

        # if all eles found & its not first time after that, generate a
        # random one from them:
        sample_arr = main_arr.sample(4)
        sample_arr = main_arr.sample(4) while skip_arr.include?(sample_arr) || skip_this_position?(sample_arr) == true
        self.comptr_turn_choice = sample_arr
      end
      comptr_turn_choice
    end

    def cater_if_all_match
      main_arr.each_with_index { |ele, idx| main_arr[idx] = ele if comptr_turn_choice.include?(ele) }
    end

    def cater_if_any_match(humn_secrt_choice)
      if hints_arr == [0, 4] # if all matches are on wrong positions
        comptr_turn_choice.each_with_index do |ele, idx|
          # then make a key of each index & store all elements in an array against
          #  this key. i.e, {0=>["o", "c"], 1=>["c", "r"]}
          skip_positn_hash[idx] += [ele] unless skip_positn_hash[idx].include?(ele)
        end
      end
      humn_secrt_choice.each_with_index do |ele, _idx|
        next unless sure_presnt.include?(ele) && comptr_turn_choice.include?(ele) && main_arr.include?(0)

        # as we need to replace zeros with found ele in ascending order so that computer
        #   player knows which eles are found but not their actual position:
        first_zero_index = main_arr.find_index(0) # find_index returns first found index
        main_arr[first_zero_index] = ele
      end
    end

    def cater_if_no_match
      # if no match found, put it in skip_arr:
      comptr_turn_choice.each { |ele| skip_arr << ele unless skip_arr.include?(ele) }
    end

    def skip_this_position?(sample_arr)
      skip_positn_hash.each do |k, _v|
        sample_arr.each_with_index do |ele, idx|
          return true if skip_positn_hash[k].include?(ele) && idx == k
        end
      end
      false
    end

    def create_hints_array(humn_secrt_choice, comptr_turn_choice) # for hints arr basically
      create_hints_array_utilmod(humn_secrt_choice, comptr_turn_choice)
    end
    # private block ends:
  end
end
