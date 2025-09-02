class AddAdditionalFieldsToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :status, :integer, default: 0
    add_column :appointments, :recomendation, :string
  end
end
