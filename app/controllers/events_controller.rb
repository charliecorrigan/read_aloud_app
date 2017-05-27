class EventsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @event = Event.new
  end

  def create
    @user = User.find(params[:user_id])
    @event = Event.new(event_params)
    if @event.save
      redirect_to user_event_path(@user, @event)
    else
      render :new
    end
  end

  def show
    
  end

  private

  def event_params
    params.require(:event).permit(:user_classroom_id, :date, :kids, :adults)
  end
end