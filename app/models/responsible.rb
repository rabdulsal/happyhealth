class Responsible < ActiveRecord::Base
  attr_accessible :address, 
                  :age, 
                  :birthdate, 
                  :city, 
                  :employer, 
                  :employer_status, 
                  :first_name, 
                  :form_id, 
                  :home_phone, 
                  :last_name, 
                  :mailing_address, 
                  :marital_status, 
                  :middle_initial, 
                  :nickname, 
                  :number_of_dependents, 
                  :occupation, 
                  :relationship_to_patient, 
                  :sex, 
                  :social_security, 
                  :state, 
                  :work_address, 
                  :work_phone, 
                  :zipcode
                  
    belongs_to :form
end
