# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      can :create_category, Category, user_id: user.id
      can :assign_category, Category, user_id: user.id
    elsif user.role == "patient"
      can :create_appointment, Appointment, user_id: user.id
    elsif user.role == "doctor"
      can :update_appointment, Appointment, user_id: user.id
    end
  end
end
