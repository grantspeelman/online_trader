# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  alias authorise authorize

  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError do |_exception|
    flash.now['alert'] = "Not allow to #{params[:action]} this"
    render :access_denied, status: 403
  end

  protected

  def current_user
    @current_user ||= User[session[:user_id]]
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :current_user, :user_signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def login_required
    return true if user_signed_in?
    store_location
    access_denied
    false
  end

  def access_denied
    if request.xhr?
      render(:update) { |page| page.redirect_to(root_path) }
    else
      redirect_to(root_path)
    end
  end

  def store_location
    session['return-to'] = request.url
  end

  def redirect_back_or_default(default)
    if session['return-to'].blank?
      redirect_to default
    else
      redirect_to session['return-to']
      session['return-to'] = nil
    end
  end
end
