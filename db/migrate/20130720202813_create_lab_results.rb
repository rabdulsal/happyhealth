class CreateLabResults < ActiveRecord::Migration
  def change
    create_table :lab_results do |t|
      t.text :lab_info
      t.string :chemical_level
      t.date :lab_date

      t.timestamps
    end
  end
end
