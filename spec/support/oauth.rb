OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:twitter, { :uid => '11111'})
OmniAuth.config.add_mock(:facebook, { :uid => '22222'})

module OauthHelper

  def login_with_oauth(oauth)
    visit "/auth/#{oauth.provider}"
  end

end

RSpec.configure do |config|
  config.include OauthHelper
end