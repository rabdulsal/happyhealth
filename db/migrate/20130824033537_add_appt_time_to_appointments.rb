class AddApptTimeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :appt_time, :time
  end
end
