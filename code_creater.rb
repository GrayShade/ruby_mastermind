# frozen_string_literal: false

# this class defines Logic for Computer player
class CodeCreator
  def initialize; end

  def cater_human_creatr; end

  def cater_cmputr_creatr(comptr_secrt_choice, humn_turn_choice)
    corect_positn_arr = []
    wrong_positon_arr = []
    comptr_secrt_choice.each_with_index do |ele, idx|
      humn_turn_choice.each_with_index do |ele2, idx2|
        corect_positn_arr << ele if ele == ele2 && idx == idx2
        wrong_positon_arr << ele if ele == ele2 && idx != idx2
      end
    end
    hints_arr = [corect_positn_arr.length, wrong_positon_arr.length]
    print "hints_arr: #{hints_arr}\n"
    hints_arr
  end
end
