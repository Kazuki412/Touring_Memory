module Public::NotificationsHelper

  def notification_message(notification)
    case notification.notifiable_type
    when "Blog"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました"
    when "Favorite"
      "投稿した#{notification.notifiable.blog.title}が#{notification.notifiable.user.name}さんにいいねされました"
    when "BlogComment"
      "投稿した#{notification.notifiable.blog.title}に#{notification.notifiable.user.name}さんからコメントが届きました"
    when "Relationship"
      "#{notification.notifiable.follower.name}さんがあなたをフォローしました"
    when "Message"
      "#{notification.notifiable.user.name}さんからメッセージが届いています"
    end
  end
end
