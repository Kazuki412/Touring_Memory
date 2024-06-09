module Public::NotificationsHelper

  def notification_message(notification)
    case notification.notifiable_type
    when "Blog"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました"
    when "Favorite"
      "投稿した#{notification.notifiable.blog.title}が#{notification.notifiable.user.name}さんにいいねされました"
    end
  end
end
