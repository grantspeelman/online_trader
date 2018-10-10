# frozen_string_literal: true

class Exceptional
  attr_reader :message

  def initialize(raw_value, message: 'invalid value')
    @raw_value = raw_value
    @message = message.clone.freeze
  end

  def to_s
    @raw_value
  end

  def to_i
    @raw_value
  end

  def exceptional?
    true
  end
end
