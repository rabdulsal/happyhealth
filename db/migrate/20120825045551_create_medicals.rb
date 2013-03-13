class CreateMedicals < ActiveRecord::Migration
  def change
    create_table :medicals do |t|
      t.integer :form_id

      t.timestamps
    end
  end
end
