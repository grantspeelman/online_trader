class Card
  include Mongoid::Document
  field :name, :type => String
  field :img_url
  validates_presence_of :name
  validates_uniqueness_of :name

  index "name", background: true, unique: true

  scope :by_name, ->(name) { where(:name => name) }

end
