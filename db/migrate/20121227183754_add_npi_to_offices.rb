class AddNpiToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :npi, :integer
  end
end
