# frozen_string_literal: true

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:developer] = OmniAuth::AuthHash.new(provider: 'developer',
                                                               uid: 'grant@email.com')

module OauthHelper
  def current_user
    OAuthAuthentication.first(provider_uid: 'grant@email.com').user
  end

  def login
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:developer]
    post '/auth/developer/callback'
  end
end

RSpec.configure do |config|
  config.include OauthHelper, type: :request
end
