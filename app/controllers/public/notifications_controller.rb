class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to notifiable_path(@notification.notifiable)
  end

  private

  def notifiable_path(notifiable)
    case notifiable
    when Blog
      blog_path(notifiable)
    when Favorite
      blog_favorite_path(notifiable)
    else
      root_path
    end
  end
end
