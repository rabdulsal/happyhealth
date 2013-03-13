class CreateInsuranceQueries < ActiveRecord::Migration
  def change
    create_table :insurance_queries do |t|
      t.string :api_key
      t.string :payer_name
      t.integer :payer_id
      t.string :physician_last_name
      t.string :physician_first_name
      t.integer :provider_npi
      t.string :subscriber_id
      t.string :subscriber_last_name
      t.string :subscriber_first_name
      t.string :subscriber_dob
      t.integer :service_type_code
      t.integer :appointment_id

      t.timestamps
    end
  end
end
