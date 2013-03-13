class AddFormIdToEmergency < ActiveRecord::Migration
  def change
    add_column :emergencies, :form_id, :integer
  end
end
