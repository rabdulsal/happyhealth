class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :doctor
      t.date :appt_date
      t.string :doctor_phone
      t.integer :user_id

      t.timestamps
    end
  end
end
