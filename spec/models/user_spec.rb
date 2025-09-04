require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create_appointment" do
    let(:user) { User.create(email: "patient1@gmail.com", phone: "38096981114", password: "1234567", role: "patient") }
    let(:other_user) { User.create(email: "patient2@gmail.com", phone: "38096981115", password: "1234567", role: "patient") }

    it "creates an appointment between two users" do
      expect {
        user.create_appointment(user, other_user)
      }.to change(Appointment, :count).by(1)
    end
  end

  describe "#delete_appointment" do
    let(:user) { User.create(email: "patient1@gmail.com", phone: "38096981114", password: "1234567", role: "patient") }
    let(:other_user) { User.create(email: "patient2@gmail.com", phone: "38096981115", password: "1234567", role: "patient") }
    let!(:appointment) { Appointment.create(creator_id: user.id, recipient_id: other_user.id)}
    
    it "deletes the appointment between two users" do
      expect {
        user.delete_appointment(user, other_user)
      }.to change(Appointment, :count).by(-1)
    end
  end

  describe "#add_doctor_to_ctegory" do
    let(:doctor) { User.create(email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor") }
    let(:category) { Category.create(name: "dentist") }

    it "assigns category to doctor" do
      expect {
        doctor.add_doctor_to_ctegory(doctor, category.name)
      }.to change(doctor.categories, :count).by(1)
    end

    it "clears existing categories before adding new one" do
      other_category = Category.create(name: "therapist")
      doctor.categories << other_category

      doctor.add_doctor_to_ctegory(doctor, category.name)
      expect(doctor.categories).to contain_exactly(category)
    end
  end

  describe "#remove_doctor_from_ctegory" do
    let(:doctor) { User.create(email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor") }
    let(:category) { Category.create(name: "dentist") }

    before { doctor.categories << category }

    it "removes doctor from categories" do
      doctor.remove_doctor_from_ctegory(doctor.id)
      expect(doctor.categories.count).to eq(0)
    end
  end
end
