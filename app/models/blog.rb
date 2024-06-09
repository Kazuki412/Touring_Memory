class Blog < ApplicationRecord

  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  after_create do
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable: self)
    end
  end

end
