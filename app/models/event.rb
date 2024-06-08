class Event < ApplicationRecord

  belongs_to :user

  def start_time
    self.start
  end
  
end
