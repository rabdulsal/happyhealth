class AddOfficeIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :office_id, :integer
  end
end
