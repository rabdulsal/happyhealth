class CreateDentals < ActiveRecord::Migration
  def change
    create_table :dentals do |t|
      t.integer :insurance_id
      t.datetime :eff_date
      t.string :dent_company
      t.integer :policy_number
      t.integer :group_number
      t.string :group_name

      t.timestamps
    end
  end
end
