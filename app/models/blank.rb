# frozen_string_literal: true

class Blank
  def initialize(raw_value = '')
    @raw_value = raw_value
  end

  def to_s
    @raw_value
  end

  def blank?
    true
  end

  def exceptional?
    false
  end
end
