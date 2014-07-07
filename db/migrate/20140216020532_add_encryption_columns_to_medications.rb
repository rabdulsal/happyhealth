class AddEncryptionColumnsToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :info_key, :string
    add_column :medications, :info_iv, :string
  end
end
