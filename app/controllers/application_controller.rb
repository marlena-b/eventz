# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def require_signin
    return if current_user

    session[:intended_url] = request.url
    redirect_to new_session_url, alert: 'Please sign in first!'
  end

  def require_admin
    return if current_user_admin?

    redirect_to root_url, alert: 'Unauthorized access!'
  end

  def current_user_admin?
    current_user&.admin?
  end

  helper_method :current_user
  helper_method :current_user?
  helper_method :current_user_admin?
end
