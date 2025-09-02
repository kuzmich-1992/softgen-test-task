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

  has_and_belongs_to_many :categories
  
  enum role: {admin: 0, doctor: 1, patient: 2}

  def create_appointment(current_user, other_user)
    Appointment.create!(creator_id: current_user.id, recipient_id: other_user.id)
  end

  def delete_appointment(current_user, other_user)
    Appointment.appointments.find_by(creator_id: current_user.id, recipient_id: other_user.id).destroy
  end
  
  def add_doctor_to_ctegory(doctor_id, category_name)
    User.find(doctor_id).categories << Category.find_by(name: category_name)
  end

  def remove_doctor_from_ctegory(doctor_id, category_name)
    User.find(doctor_id).categories.clear
  end
end
