require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'NC5rkqjoiWmQqMqg9hJZA', '50crDzCTln7h07FhrD4dfsD0PNqxsOKtBz7HE7OXM'
  provider :facebook, '326713784029745', '31c7237b4280f806a1ecb5ebd4482447', :grant_type => 'client_credentials'
  provider :google, '363313196425.apps.googleusercontent.com', 'WkaDfmQjwdFrYt4l3GO2YgcE'
  # use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new(Rails.root.join('tmp'))
end