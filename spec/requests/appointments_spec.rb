require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  describe "POST #create" do
    let(:current_user) { User.create(email: "patient1@gmail.com", phone: "38096981114", password: "1234567", role: "patient") }
    let(:doctor) { User.create(email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor") }
    context "when doctor has fewer than 10 open appointments" do
      it "creates a new appointment and redirects to root_path" do
        sign_in current_user
        expect {
          post :create, params: { user_id: doctor.id }
        }.to change(Appointment, :count).by(1)

        expect(response).to redirect_to(root_path)
      end
    end

    context "when doctor has 10 or more open appointments" do
      before do
        10.times { Appointment.create!(creator_id: current_user.id, recipient_id: doctor.id, recomendation: "example") }
      end

      it "does not create appointment and redirects with notice" do
        sign_in current_user
        expect {
          post :create, params: { user_id: doctor.id }
        }.not_to change(Appointment, :count)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Doctor is busy. Shedule consultation later!")
      end
    end
  end

  describe "PATCH #update" do
    let(:current_user) { User.create(email: "patient1@gmail.com", phone: "38096981114", password: "1234567", role: "patient") }
    let(:doctor) { User.create(email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor") }
    let(:appointment) { Appointment.create(creator_id: current_user.id, recipient_id: doctor.id) }

    it "updates appointment with recommendation and closes it" do
      patch :update, params: { id: appointment.id, recomendation: "Take rest" }

      expect(appointment.reload.recomendation).to eq("Take rest")
      expect(appointment.reload.status).to eq("closed")
      expect(response).to redirect_to(root_path)
    end
  end
end

