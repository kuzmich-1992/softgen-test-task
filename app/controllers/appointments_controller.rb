class AppointmentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.create_appointment(current_user, @user)
    redirect_to root_path
  end
end
