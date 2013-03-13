class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :info
      t.integer :medical_id

      t.timestamps
    end
  end
end
