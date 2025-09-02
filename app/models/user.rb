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

  enum role: {admin: 0, doctor: 1, patient: 2}

  def create_appointment(current_user, other_user)
    Appointment.create!(creator_id: current_user.id, recipient_id: other_user.id)
  end

  def delete_appointment(current_user, other_user)
    Appointment.appointments.find_by(creator_id: current_user.id, recipient_id: other_user.id).destroy
  end
end
