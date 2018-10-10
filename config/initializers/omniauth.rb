# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer

  use OmniAuth::Strategies::CognitoIdP,
      ENV['COGNITO_CLIENT_ID'],
      ENV['COGNITO_CLIENT_SECRET'],
      client_options: {
        site: ENV['COGNITO_USER_POOL_SITE']
      },
      scope: 'email openid aws.cognito.signin.user.admin profile'
end
