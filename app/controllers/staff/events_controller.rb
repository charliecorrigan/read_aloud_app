class Staff::EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def edit
    @user = User.find_by(params[:user_id])
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to staff_events_path
  end
end