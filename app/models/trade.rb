class Trade
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :with_user, :class_name => 'User'

  field :user_cards, type: Array, default: ([''] * 10)
  field :with_user_cards, type: Array, default:([''] * 10)

  attr_accessor :trade_with

  before_validation :set_with_user, :on => :create

  validate :minimum_cards, :check_with_user
  validates_presence_of :user_id
  validates_presence_of :with_user_id, :message => 'does not exist'
  attr_protected :user_id, :with_user_id

  def user_card_count
    card_count(user_cards)
  end

  def with_user_cards_count
    card_count(with_user_cards)
  end

  def to_s
    "#{user_card_count} #{user} cards for #{with_user_cards_count} #{with_user} cards"
  end

  protected

  def set_with_user
     unless trade_with.blank?
        tmp_user = User.where(:ign => trade_with).first
        self.with_user_id = tmp_user.id if tmp_user
     end
  end

  def minimum_cards
    errors.add(:user_cards,'can\'t be empty') if user_card_count == 0
    errors.add(:with_user_cards,'can\'t be empty') if with_user_cards_count == 0
  end

  def check_with_user
    if with_user == user
      errors.add(:with_user_id,'does not exist')
    end
  end

  private

  def card_count(c)
    c.inject(0) do |non_blanks,text|
      if text.blank?
        non_blanks
      else
        non_blanks += 1
      end
    end
  end

end
