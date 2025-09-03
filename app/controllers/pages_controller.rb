class PagesController < ApplicationController
  def index
    if params[:search_category].present?
      @doctors = User.where(role: "doctor").joins(:categories).where("categories.name" => params[:search_category])
    else
      @doctors = User.where(role: "doctor")
    end
  end

  def create_category
    @category = Category.create(name: params[:category][:name])
    redirect_to root_path
  end

  def assign_category
    @doctor = User.find(params[:doctor_id])
    @doctor.add_doctor_to_ctegory(@doctor, params[:assign_category])
    redirect_to root_path
  end
end
