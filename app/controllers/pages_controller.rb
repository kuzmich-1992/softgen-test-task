class PagesController < ApplicationController
  def index
    @doctors = User.where(role: "doctor").joins(:categories).where("categories.name" => params[:search_category])
  end
end
