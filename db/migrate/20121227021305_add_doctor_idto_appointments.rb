class AddDoctorIdtoAppointments < ActiveRecord::Migration
  def up
  	add_column :appointments, :doctor_id, :integer
  end

  def down
  	remove_column :appointments, :doctor_id
  end
end
