class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :email_confirmation, :login
  
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

  validates_format_of :phone, with: /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/, :multiline => true, :allow_blank => true
  
  enum role: {admin: 0, doctor: 1, patient: 2}

  def create_appointment(current_user, other_user)
    Appointment.create!(creator_id: current_user.id, recipient_id: other_user.id)
  end

  def delete_appointment(current_user, other_user)
    Appointment.appointments.find_by(creator_id: current_user.id, recipient_id: other_user.id).destroy
  end
  
  def add_doctor_to_ctegory(doctor, category_name)
    category = Category.find_by(name: category_name)
    if doctor.categories.blank?
      doctor.categories << category
    elsif doctor.categories.present?
      doctor.categories.clear
      doctor.categories << category
    end
  end

  def remove_doctor_from_ctegory(doctor_id, category_name)
    User.find(doctor_id).categories.clear
  end

  def login
    @login || self.phone || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(phone) ILIKE '%#{login.downcase}%' OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end

