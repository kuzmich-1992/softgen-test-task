class Appointment < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :creator_id, presence: true
  validates :recipient_id, presence: true
  validates :creator_id, uniqueness: { scope: :recipient_id }
end

