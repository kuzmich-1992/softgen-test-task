class Appointment < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :recipient, class_name: "User"
  
  enum status: {open: 0, closed: 1}

  validates :creator_id, presence: true
  validates :recipient_id, presence: true
end

