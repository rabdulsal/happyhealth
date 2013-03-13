class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :title
      t.string :relationship_to_patient
      t.string :company
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :group_number
      t.string :group_name
      t.date :eff_date
      t.string :policy_number
      t.string :subscribers_last_name
      t.string :subscribers_first_name
      t.string :middle_initial
      t.string :subscribers_address
      t.string :subscribers_city
      t.string :subscribers_state
      t.string :subscribers_zipcode
      t.string :social_security
      t.string :birthdate
      t.string :sex
      t.string :subscribers_phone
      t.string :subscribers_employer

      t.timestamps
    end
  end
end
