class Public::BlocksController < ApplicationController

  def create
    current_user.block(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unblock(params[:user_id])
    redirect_to request.referer
  end
end
