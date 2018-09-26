# frozen_string_literal: true

class SessionsController < ApplicationController
  protect_from_forgery except: %i[create destroy]

  def create
    create_auth
    # Log the authorizing user in.
    self.current_user = @auth.user

    flash[:notice] = "Welcome, #{current_user.name}."
    redirect_to(@first_login ? edit_user_path(current_user) : root_path)
  end

  def failure
    flash[:error] = params[:message]&.humanize || 'Authentication failed'
    redirect_to(login_path)
  end

  def destroy
    # Log the authorizing user in.
    session[:user_id] = nil
    flash[:notice] = 'Succesfully logged Out'
    redirect_to(root_path)
  end

  private

  def create_auth
    return nil if (@auth = OAuthAuthentication.find_from_hash(auth_hash))
    @first_login = true
    # Create a new user or add an auth to existing user, depending on
    # whether there is already a user signed in.
    @auth = OAuthAuthentication.create_from_hash(auth_hash, current_user)
  end

  def auth_hash
    { provider: request.env['omniauth.auth']['provider'].to_s,
      uid: request.env['omniauth.auth']['uid'].to_s,
      name: request.env.dig('omniauth.auth', 'info', 'name').to_s }
  end
end
