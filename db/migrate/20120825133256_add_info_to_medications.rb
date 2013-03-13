class AddInfoToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :info, :string
  end
end
