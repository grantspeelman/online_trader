class Want
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity

  property 'id',        Serial
  property 'card_name', String, required: true, unique: :user_id, index: true
  property 'amount',    Integer, default: 1, required: true
  property 'value',     Integer, default: 3, required: true

  validates_numericality_of :amount, :greater_than => 0, :only_integer => true
  validates_numericality_of :value, :greater_than => 0, :less_than => 6, :only_integer => true

  belongs_to :user
  attr_protected :user_id

  def by_card_name(name)
    all(:card_name => name)
  end

  def card
    Card.by_name(card_name).first
  end

  def haves
    @haves ||= Have.all(:card_name => card_name)
  end

  def have_count
    haves.count
  end

end

