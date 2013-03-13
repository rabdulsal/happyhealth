class AddAddressToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :address, :string
    add_column :offices, :city, :string
    add_column :offices, :state, :string
    add_column :offices, :zipcode, :string
    add_column :offices, :phone, :string
    add_column :offices, :fax, :string
    add_column :offices, :email, :string
  end
end
