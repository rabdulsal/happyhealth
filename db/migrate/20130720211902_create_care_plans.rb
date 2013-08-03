class CreateCarePlans < ActiveRecord::Migration
  def change
    create_table :care_plans do |t|
      t.text :activity
      t.date :activity_date

      t.timestamps
    end
  end
end
