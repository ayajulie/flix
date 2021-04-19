class ApplicationController < ActionController::Base
  add_flash_types(:danger)

  private

  def require_signin
    unless current_user
      session[:inteded_url] = request.url
      redirect_to new_session_url, alert: 'Please sign in first!'
    end
  end

  def current_user
    # User.find(session[:user_id]) if session[:user_id] # looks firts if there's an id in the sessions
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # to optimize callings to the db
  end
  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
end
