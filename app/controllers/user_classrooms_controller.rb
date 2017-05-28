class UserClassroomsController < ApplicationController
  def new
  end

  def create
    UserClassroom.create(classroom_params)
    redirect_to user_profiles_path(params[:user_classroom][:user_id])
  end

  private

  def classroom_params
    params.require(:user_classroom).permit(:user_id, :classroom_id)
  end

end
