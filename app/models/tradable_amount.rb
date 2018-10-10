# frozen_string_literal: true

class TradableAmount
  # @param [String] name
  def initialize(name)
    raise ArgumentError, 'Tradable amount cannot be blank' if name.blank?

    @raw_int = Integer(name.to_s)

    raise ArgumentError, "#{@raw_int.inspect} is less than 1" unless @raw_int.positive?
    freeze
  end

  def to_s
    @raw_int.to_s
  end

  def to_i
    @raw_int
  end

  def exceptional?
    false
  end

  # allows this object to be used in sequel queries
  def sql_literal(object)
    object.literal(to_i)
  end

  # @param [TradableAmount] other
  def ==(other)
    to_i == other.to_i
  end

  # @param [Object] raw_amount
  def self.cast(raw_amount)
    return raw_amount if raw_amount.is_a?(TradableAmount)
    return Blank.new if raw_amount.blank?
    new(raw_amount)
  rescue ArgumentError => error
    Exceptional.new(raw_amount, message: error.message)
  end
end
