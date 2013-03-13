class CreateResponsibles < ActiveRecord::Migration
  def change
    create_table :responsibles do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_initial
      t.string :relationship_to_patient
      t.string :nickname
      t.string :address
      t.string :marital_status
      t.string :mailing_address
      t.string :number_of_dependents
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :social_security
      t.string :sex
      t.string :birthdate
      t.integer :age
      t.string :home_phone
      t.string :work_phone
      t.string :employer
      t.string :employer_status
      t.string :occupation
      t.string :work_address
      t.integer :form_id

      t.timestamps
    end
  end
end
