class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(session[:user_id])
    @user_new_parks = @user.new_parks
    @user_new_events = @user.new_events
    @all_user_events = @user.user_new_events
    @all_user_parks = @user.user_new_parks
  end

  def search_results
    @user = User.find(session[:user_id])
    @park = NewPark.find_by(id: params[:park_id])

    radius = params[:radius].to_i * 1609.34
    q = params[:q]

    location = @park.longitude.to_s + "," + @park.latitude.to_s
    circle = @park.longitude.to_s + "," + @park.latitude.to_s + "," +  radius.to_s
    sort = 'distance'
    if q == ''
      flash.now[:notice] = 'please enter a search term'
      redirect_to user_path(@user)
    else
      @response = MapFacade.get_service(location, q, circle, sort)
    end
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

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(session[:user_id])
    if user.update(user_params)
      redirect_to user_path(user)
      flash[:notice] = 'Profile updated!'
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
    params.require(:user).permit(:first_name, :last_name, :username, :state, :password, :password_confirmation)
  end
end
