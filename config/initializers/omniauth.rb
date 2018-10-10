# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer

  use OmniAuth::Strategies::CognitoIdP,
      ENV['CLIENT_ID'],
      ENV['CLIENT_SECRET'],
      client_options: {
        site: ENV['COGNITO_USER_POOL_SITE']
      },
      scope: 'email openid aws.cognito.signin.user.admin profile'
end
