class ChangesToDentalAndVision < ActiveRecord::Migration
  def change
  	remove_column :dentals, :insurance_id
  	remove_column :visions, :insurance_id
  	add_column :dentals, :form_id, :integer
  	add_column :visions, :form_id, :integer
  end
end
