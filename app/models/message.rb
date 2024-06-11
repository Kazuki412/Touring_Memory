class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :content, presence: true

  after_create do
    room.users.each do |recipient|
      unless recipient == user
        create_notification(user: recipient)
      end
    end
  end
end
