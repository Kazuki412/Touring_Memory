class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end
end
