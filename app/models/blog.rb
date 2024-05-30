class Blog < ApplicationRecord

  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  
end
