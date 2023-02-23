# frozen_string_literal: false

# this class defines Logic for Computer player
class CodeCreator
  def initialize; end

  def cater_human_creatr; end

  def cater_cmputr_creatr(comptr_secrt_choice, humn_turn_choice)
    corect_positn_arr = []
    wrong_positon_arr = []
    # puts "Secret choice was: #{inpt_secrt_choice}"
    # puts "Human choice was:  #{humn_color_choice}"
    comptr_secrt_choice.each_with_index do |ele, idx|
      humn_turn_choice.each_with_index do |ele2, idx2|
        corect_positn_arr << ele if ele == ele2 && idx == idx2
        wrong_positon_arr << ele if ele == ele2 && idx != idx2
      end
    end
    # print "correct_positon_arr: #{corect_positn_arr}"
    # print "\nwrong_positon_arr:   #{wrong_positon_arr}\n"
    # show_hints(correct_positon_arr, wrong_positon_arr)
    hints_arr = [corect_positn_arr.length, wrong_positon_arr.length]
  end

  # def calculate_hints(corect_positn_arr, wrong_positon_arr)
  #   # hints_hash = { 'Correct Positions:' => corect_positn_arr.length, 'Wrong Positions:' => wrong_positon_arr.length }
  # end
end
