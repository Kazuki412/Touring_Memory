class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :blog
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :blog_id}
  
  after_create do
    create_notification(user_id: blog.user_id)
  end
end
