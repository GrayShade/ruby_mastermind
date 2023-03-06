# frozen_string_literal: false

require_relative 'utilmod'
# this class defines Logic for Computer player as code creator
class CodeCreator
  include UtilMod
  attr_accessor :sure_presnt, :hints_arr

  def initialize
    self.sure_presnt = []
  end

  def cater_human_creatr; end

  def cater_cmputr_creatr(comptr_secrt_choice, humn_turn_choice)
    create_hints_array_utilmod(comptr_secrt_choice, humn_turn_choice)
  end
end
