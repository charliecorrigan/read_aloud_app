class ProfilesController < ApplicationController
  before_action :set_user
  before_action :volunteer_and_not_owner

  def index
    @user_classroom = UserClassroom.new
  end
end