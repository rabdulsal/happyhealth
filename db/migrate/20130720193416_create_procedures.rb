class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :procedure
      t.date :procedure_date
      t.string :target_site
      t.integer :medical_id

      t.timestamps
    end
  end
end
