class Authorization
  include Mongoid::Document
  belongs_to :user
  field :uid
  field :provider

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  after_destroy :destroy_user

  def self.find_from_hash(hash)
    where(:uid => hash[:uid], :provider => hash[:provider]).first
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create(:name => hash[:name])
    Authorization.create(:user => user, :uid => hash[:uid], :provider => hash[:provider])
  end

  protected

  def destroy_user
    user.destroy if user && user.authorizations.empty?
  end
end