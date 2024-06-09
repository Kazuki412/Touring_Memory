module Public::NotificationsHelper

  def notifiable_path(notifiable)
    case notifiable
    when Blog
      blog_path(notifiable)
    when Favorite
      blog_favorite_path(notifiable)
    end
  end
end
