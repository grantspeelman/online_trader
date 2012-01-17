class Card
  include Mongoid::Document
  field :name, :type => String
  validates_presence_of :name
  validates_uniqueness_of :name

  index "name", background: true, unique: true

end
