class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :type
      t.string :reason
      t.integer :medical_id

      t.timestamps
    end
  end
end
