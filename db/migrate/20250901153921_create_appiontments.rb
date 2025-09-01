class CreateAppiontments < ActiveRecord::Migration[7.0]
  def change
    create_table :appiontments do |t|
      t.integer :creator_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
