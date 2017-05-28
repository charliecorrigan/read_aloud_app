class ProfilesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @user_classroom = UserClassroom.new
  end
end