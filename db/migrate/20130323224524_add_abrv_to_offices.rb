class AddAbrvToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :abrv, :string
  end
end
