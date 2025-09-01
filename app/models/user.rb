class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :appointments, class_name: "Appointment",
                          foreign_key: "creator_id",
                          dependent: :destroy
  has_many :recipients, through: :appointments, source: :recipient

  has_many :appointments, class_name: "Appointment",
                          foreign_key: "recipient_id",
                          dependent: :destroy
  has_many :creators, through: :appointments, source: :creator

  def create_appointment(other_user)
    active_relationships.create(recipient_id: other_user.id)
  end

  def delete_appointment(other_user)
    active_relationships.find_by(recipient_id: other_user.id).destroy
  end

  def appointment_present?(other_user)
    recipients.include?(other_user)
  end
end
