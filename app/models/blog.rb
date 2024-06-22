class Blog < ApplicationRecord

  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  after_create do
    user.follower_users.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end

  # ブロックしている・されているの関係にある場合、表示しない
  scope :visible_to, ->(user) {
    blocked_user_ids = user.blocking_users.pluck(:id) + user.blocker_users.pluck(:id)
    where.not(user_id: blocked_user_ids)
  }
end
