class AddPayerCodeToInsuranceQueries < ActiveRecord::Migration
  def change
    add_column :insurance_queries, :payer_code, :integer
  end
end
