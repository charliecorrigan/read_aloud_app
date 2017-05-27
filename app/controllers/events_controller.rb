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
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to user_events_path(@user)
  end

  def edit
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
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