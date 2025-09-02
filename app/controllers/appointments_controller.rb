class AppointmentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.create_appointment(current_user, @user)
    redirect_to root_path
  end

  def update
    @appointment = Appointment.find(params[:id].to_i).update(recomendation: params[:recomendation], status: "closed")
    redirect_to root_path
  end

  def user_params
    params.require(:appointment).permit(:id)
  end
end
