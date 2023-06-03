# frozen_string_literal: false

module UtilMod
  # guesses = 12
  def show_colors_utilmod
    %w[r g b w c o]
  end

  def create_hints_array_utilmod(secrt_choice, curent_choice) # for hints arr basically
    corect_positn_arr = []
    wrong_positon_arr = []
    secrt_choice.each_with_index do |ele, idx|
      curent_choice.each_with_index do |ele2, idx2|
        if ele == ele2 && idx == idx2
          corect_positn_arr[idx] = ele # these element are present on correct indices
          # sure_present can only be for correct_position_arr as in case of wrong positions
          #  like [0, 3], there is no gurentee that which 4th element is actually not in secret
          #  choice:
          sure_presnt << ele unless sure_presnt.include?(ele)
        # wrong_positon_arr needs to be checked seperately to not fill wrong position array
        #  in case these values are already catered by correct position array:
        elsif ele == ele2 && secrt_choice[idx2] != ele2
          wrong_positon_arr[idx2] = ele # these element are present but on wrong indices
        end
      end
    end
    corect_positn_length = corect_positn_arr.count { |ele| !ele.nil? }
    wrong_positn_length = wrong_positon_arr.count { |ele| !ele.nil? }
    self.hints_arr = [corect_positn_length, wrong_positn_length]
    hints_arr
  end
end
