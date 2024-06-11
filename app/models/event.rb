class Event < ApplicationRecord

  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  def start_time
    self.start
  end
  
  after_create :create_notifications
  after_update :create_notifications

  def create_notifications
    if start.to_date == Date.current
      create_notification(user_id: self.user_id)
    end
  end
end
