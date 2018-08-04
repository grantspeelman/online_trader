class OAuthAuthentication < Sequel::Model
  many_to_one :user

  def self.find_from_hash(hash)
    first(provider_uid: hash[:uid], provider_name: hash[:provider])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create(name: hash.fetch(:name))
    create(user: user,
           provider_uid: hash.fetch(:uid),
           provider_name: hash.fetch(:provider))
  end

  plugin :validation_helpers
  def validate
    super
    validates_presence %i[provider_uid provider_name]
    validates_unique :provider_uid, scope: :provider_name
  end
end
