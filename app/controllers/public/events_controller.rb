class Public::EventsController < ApplicationController

  def new
    @event = Event.new(start: params[:datetime])
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save
    redirect_to user_path(current_user.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to user_path(current_user.id)
  end

  private

  def event_params
    params.require(:event).permit(:title, :detail, :start, :end)
  end
end
