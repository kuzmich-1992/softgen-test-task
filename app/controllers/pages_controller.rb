class PagesController < ApplicationController
  def index
    if params[:search_category].present?
      @doctors = User.where(role: "doctor").joins(:categories).where("categories.name" => params[:search_category])
    else
      @doctors = User.where(role: "doctor")
    end
  end
end
