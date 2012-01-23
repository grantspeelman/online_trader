class User
  include Mongoid::Document
  has_many :authorizations
  has_many :wants
  has_many :haves
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  field :name, :type => String
  field :role
  field :ign, :type => String
  field :timezone
  validates_presence_of :name
  attr_protected :role
#  validates_uniqueness_of :name, :email, :case_sensitive => false
#  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  def authorized_with_everything
    self.authorizations.count == 3
  end

  def authorized_with(provider)
    self.authorizations.where(:provider => provider.to_s).exists?
  end

  def to_s
    if ign.blank?
      name
    else
      "#{name} (#{ign})"
    end
  end

  def traders_for
    1
  end

end

