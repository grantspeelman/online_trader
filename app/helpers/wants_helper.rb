# frozen_string_literal: true

module WantsHelper
  def priority_text(number)
    { 1 => 'Very Low',
      2 => 'Low',
      3 => 'Normal',
      4 => 'High',
      5 => 'Very High' }.fetch(number, '')
  end
end
