class AddDetailsToAllergies < ActiveRecord::Migration
  def change
    add_column :allergies, :reaction, :text
    add_column :allergies, :severity, :string
    add_column :allergies, :status, :string
  end
end
