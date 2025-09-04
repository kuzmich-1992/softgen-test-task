require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET #index" do
    let!(:category) { Category.create(name: "dentist") }
    let!(:doctors)  { 10.times { User.create(email: Faker::Internet.email, 
                                             phone: Faker::PhoneNumber.cell_phone_in_e164, 
                                             password: "1234567", 
                                             role: "doctor") }}
    let!(:doctor_with_category) do
      doc = User.where(role: "doctor").first
      doc.categories << category
      doc
    end

    context "without search_category param" do
      it "returns all doctors" do
        get pages_path
        expect(User.where(role: "doctor")).to be_present
      end
    end

    context "with search_category param" do
      before { get pages_path, params: { search_category: "dentist" } }
      it "returns doctors filtered by category" do
        expect(assigns(:doctors)).to match_array([doctor_with_category])
      end
    end
  end

  describe "POST #create_category" do
    it "creates a new category" do
      expect {
        post create_category_path, params: { category: { name: "Dermatology" } }
      }.to change(Category, :count).by(1)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #assign_category" do
    let(:doctor) { User.create(email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor") }
    let!(:category) { Category.create(name: "dentist") }

    before do
      # stub the custom method to avoid implementation dependency
      allow_any_instance_of(User).to receive(:add_doctor_to_ctegory)
    end

    it "assigns category to doctor" do
      patch assign_category_path, params: { doctor_id: doctor.id, assign_category: category.id }

      expect(response).to redirect_to(root_path)
      expect(assigns(:doctor)).to eq(doctor)
    end
  end
end
