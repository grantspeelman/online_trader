class Want
  include Mongoid::Document
  belongs_to :user

  field :card_name
  field :priority, :type => Integer, :default => 2
  field :amount, :type => Integer, :default => 1
  validates_presence_of :card_name, :user_id
  validates_uniqueness_of :card_name, :scope => :user_id
  validates_numericality_of :amount, :greater_than => 0, :only_integer => true
  validates_numericality_of :priority, :greater_than => 0, :less_than => 6, :only_integer => true

  attr_protected :user_id

  default_scope desc(:priority)
  scope :by_card_name, ->(name) { where(:card_name => name) }

  index "card_name", background: true

  def card
    Card.by_name(card_name).first
  end

end

