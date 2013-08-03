class CreateImmunizations < ActiveRecord::Migration
  def change
    create_table :immunizations do |t|
      t.string :vaccination
      t.date :vaccination_date
      t.string :status
      t.integer :medical_id

      t.timestamps
    end
  end
end
