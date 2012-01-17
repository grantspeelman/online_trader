require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'NC5rkqjoiWmQqMqg9hJZA', '50crDzCTln7h07FhrD4dfsD0PNqxsOKtBz7HE7OXM'
  # provider :facebook, '195846973763305', '65bc5413e0a214ef4ce402e207f117b0', :grant_type => 'client_credentials'
  use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new(Rails.root.join('tmp'))
end