# frozen_string_literal: true

class Trade
  include DataMapper::Resource

  property 'id', Serial
  timestamps :at
end
