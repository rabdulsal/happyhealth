class CreateVitalStatistics < ActiveRecord::Migration
  def change
    create_table :vital_statistics do |t|
      t.integer :height
      t.integer :weight
      t.integer :bmi
      t.string :blood_type
      t.integer :systolic_bp
      t.integer :diastolic_bp
      t.integer :body_temp

      t.timestamps
    end
  end
end
