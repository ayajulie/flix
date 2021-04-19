module ApplicationHelper
  def current_user
    # User.find(session[:user_id]) if session[:user_id] # looks firts if there's an id in the sessions
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # to optimize callings to the db
  end
end
