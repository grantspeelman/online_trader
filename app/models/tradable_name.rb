# frozen_string_literal: true

class TradableName
  # @param [String] name
  def initialize(name)
    raise ArgumentError, 'Tradable name cannot be blank' if name.blank?

    @raw_name = name.to_str.clone.freeze
    freeze
  end

  def to_s
    @raw_name.clone
  end

  alias to_str to_s

  def exceptional?
    false
  end

  # @param [TradableName] other
  def ==(other)
    to_s == other.to_s
  end

  # allows this object to be used in sequel queries
  def sql_literal(object)
    object.literal(to_s)
  end

  # @param [Object] raw_string
  def self.cast(raw_string)
    return raw_string if raw_string.is_a?(TradableName)
    return Blank.new if raw_string.blank?
    new(raw_string)
  end
end
