class UsersController < ApplicationController
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Thank you for Signing up'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    # @user = User.find(params[:id])  not needed anymore because called in the before_action
  end

  def update
    # @user = User.find(params[:id]) not needed anymore because called in the before_action require correct user
    @user = User.find
    session[:user_id] = @user.id
    if @user.update(user_params)
      redirect_to @user, notice: 'Account sucessfully updated!'
    else
      render :edit
    end
  end

  def destroy
    # @user = User.find(params[:id]) not needed anymore because called in the before_action
    @user.User.find(params[:id])
    @user.destroy
    # session[:user_id] = nil # To destroy the user id in the session after having run the action
    redirect_to movies_url, alert: 'Account successfully deleted!'
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to movies_url unless current_user?(@user)
    # unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
