class AppointmentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if @user.appointments.where(status: "open").count < 10
      @user.create_appointment(current_user, @user)
      redirect_to root_path
    elsif @user.appointments.where(status: "open").count >= 10
      redirect_to root_path, notice: "Doctor is busy. Shedule consultation later!"
    end
  end

  def update
    @appointment = Appointment.find(params[:id].to_i).update(recomendation: params[:recomendation], status: "closed")
    redirect_to root_path
  end
end
