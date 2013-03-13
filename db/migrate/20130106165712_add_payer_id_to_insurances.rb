class AddPayerIdToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :payer_id, :integer
  end
end
