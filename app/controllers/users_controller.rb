class UsersController < ApplicationController
  before_action :set_user_by_id, only: [:edit, :update, :destroy]
  before_action :require_admin_or_staff, except: [:show]

  def set_user_by_id
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id unless session[:user_id]
      redirect_to user_profiles_path(@user)
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_profiles_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :language, :role)
  end
end
