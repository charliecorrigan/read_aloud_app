class EventsController < ApplicationController
  before_action :set_user_by_user_id
  before_action :volunteer_and_not_owner

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to user_event_path(@user, @event)
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = @user.events.order(date: :desc)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to user_events_path(@user)
  end

  def edit
    @event = Event.find(params[:id])
    
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to user_event_path(@user, @event)
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:user_classroom_id, :date, :kids, :adults)
  end
end