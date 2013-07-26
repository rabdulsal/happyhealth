class CreateDischargeInstructions < ActiveRecord::Migration
  def change
    create_table :discharge_instructions do |t|
      t.text :instruction
      t.integer :appointment_id

      t.timestamps
    end
  end
end
