class BlogComment < ApplicationRecord

  belongs_to :user
  belongs_to :blog
  has_one :notification, as: :notifiable, dependent: :destroy
  
end
