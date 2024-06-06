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
      notifications.create(user_id: follower.id)
    end
  end

end
