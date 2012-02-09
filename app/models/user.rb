class User
  include Mongoid::Document
  has_many :authorizations
  has_many :wants
  has_many :haves
  has_many :trades
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  field :name, :type => String
  field :role
  field :ign, :type => String
  field :timezone
  validates_presence_of :name
  validates_uniqueness_of :ign, :allow_blank => true
  attr_protected :role
#  validates_uniqueness_of :name, :email, :case_sensitive => false
#  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def authorized_with(provider)
    self.authorizations.where(:provider => provider.to_s).exists?
  end

  def to_s
    if ign.blank?
      name
    else
      ign
    end
  end

  def want_card_names
    wants.only(:card_name).collect{|t|t.card_name}
  end

  def have_card_names
    haves.only(:card_name).collect{|t|t.card_name}
  end

  def wants_for(user)
    user.wants.where(:card_name => {"$in" => have_card_names})
  end

  def trades
    Trade.any_of({with_user_id: id},{user_id: id})
  end

end

