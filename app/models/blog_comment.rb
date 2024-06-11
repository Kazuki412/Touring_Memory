class BlogComment < ApplicationRecord

  belongs_to :user
  belongs_to :blog
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    unless blog.user == user
      create_notification(user_id: blog.user_id)
    end
  end

end
