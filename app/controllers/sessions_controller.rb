class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])
    if user && user.authenticate(params[:password]) # check if nil and correct password
      session[:user_id] = user.id # put user id in session
      redirect_to user, notice: "Welcome back #{user.name}"
    else
      flash.now[:alert] = 'Invalid credentials' # .now displays the alert before rendering
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_url, notice: "You're now signed out!"
  end
end
