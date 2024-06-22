class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_block, only: [:show]

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
  
  private

  # ブロックされている場合、トップページへ
  def check_block
    @room = Room.find(params[:id])
    blocked_users = @room.users.joins(:blockers).where(blocks: { blocked_id: current_user.id }).distinct
    if blocked_users.exists?
      redirect_to root_path, alert: "このルームにアクセスする権限がありません。"
    end
  end
end
