class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return render "new" unless user_params[:password] == user_params[:password_confirmation] && @user.valid?
    user.save
    session[:user_id] = user.id
    redirect_to posts_path
  end

  def signin
    @user = User.new
  end

  def login
    user = User.find_by_email(user_params[:email])
    return redirect_to signin_user_path unless user && user.authenticate(user_params[:password])
    session[:user_id] = user.id
    redirect_to posts_path
  end

  def logout
    session.destroy
    redirect_to signin_user_path
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit([:username, :password, :password_confirmation, :email])
  end
end
