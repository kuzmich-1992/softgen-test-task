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
end
