class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.where(read: false).order(created_at: :desc)
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "Blog"
      redirect_to blog_path(notification.notifiable)
    when "Favorite"
      favorite = notification.notifiable
      redirect_to blog_path(favorite.blog)
    when "BlogComment"
      blog_comment = notification.notifiable
      redirect_to blog_path(blog_comment.blog)
    when "Relationship"
      redirect_to user_path(notification.notifiable.follower)
    when "Message"
      redirect_to room_path(notification.notifiable.room)
    when "Event"
      redirect_to event_path(notification.notifiable)
    else 
      redirect_to user_path(notification.notifiable.user)
    end
  end
end
