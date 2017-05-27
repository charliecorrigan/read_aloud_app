class EventsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @event = Event.new
  end

  def create
    binding.pry
    @user = User.find(params[:user_id])
    @event = Event.new(event_params)
  end

  private

  def event_params
    params.require(:event).permit(:user_classroom_id, :date, :kids, :adults)
  end
end