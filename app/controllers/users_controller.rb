class UsersController < ApplicationController
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
      log_in @user
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user.nil?
      render :login_form
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      render :login_form
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :username, :state, :password, :password_confirmation)
  end
end
