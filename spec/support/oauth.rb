# frozen_string_literal: true

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:developer, uid: '11111', info: { name: 'Billy Bob' })
OmniAuth.config.add_mock(:developer, uid: '22222', info: { name: 'Grant Speelman' })
OmniAuth.config.add_mock(:developer, uid: '33333', info: { name: 'James Bond' })

module OauthHelper
  def login_with_oauth(oauth)
    visit "/auth/#{oauth.provider}"
  end
end

RSpec.configure do |config|
  config.include OauthHelper
end
