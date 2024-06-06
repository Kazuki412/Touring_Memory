class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
    # フォロー、フォロワー一覧
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    # いいね一覧
    favorites = Favorite.where(user_id: @user.id).pluck(:blog_id)
    @favorite_blogs = Blog.find(favorites)
    # DM関係
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end
