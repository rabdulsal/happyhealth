class AddTosPrivToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :tos_priv, :boolean, default: false
  end
end
