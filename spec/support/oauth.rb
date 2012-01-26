OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:twitter, { :uid => '11111', :info => {:name => "Billy Bob"}})
OmniAuth.config.add_mock(:facebook, { :uid => '22222', :info => {:name => "Grant Speelman"}})
OmniAuth.config.add_mock(:google, { :uid => '33333', :info => {:name => "James Bond"}})

module OauthHelper

  def login_with_oauth(oauth)
    visit "/auth/#{oauth.provider}"
  end

end

RSpec.configure do |config|
  config.include OauthHelper
end