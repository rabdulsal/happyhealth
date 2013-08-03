class CreateDischargeMedications < ActiveRecord::Migration
  def change
    create_table :discharge_medications do |t|
      t.integer :appointment_id

      t.timestamps
    end
  end
end
