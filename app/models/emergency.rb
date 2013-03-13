class Emergency < ActiveRecord::Base
  attr_accessible :address, 
                  :city, 
                  :name, 
                  :phone_number, 
                  :relationship_to_patient, 
                  :state, 
                  :zipcode,
                  :form_id
                  
  belongs_to :form
end
