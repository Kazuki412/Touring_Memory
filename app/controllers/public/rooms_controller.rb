class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @current_entry = Entry.create(room_id: @room.id, user_id: current_user.id)
    @another_entry = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def index
    my_room = []
    current_user.entries.each do |entry|
      my_room << entry.room.id
    end
    @my_rooms = Room.where(id: my_room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
    @entries = @room.entries
  end

  def destroy
    Room.find(params[:id]).destroy
    redirect_to request.referer
  end
  
end
