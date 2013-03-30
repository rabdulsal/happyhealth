class Insurance < ActiveRecord::Base
  attr_accessible :address, 
                  :birthdate, 
                  :city, 
                  :company, 
                  :eff_date, 
                  :group_name, 
                  :group_number,
                  :middle_initial, 
                  :policy_number, 
                  :relationship_to_patient, 
                  :sex, 
                  :social_security, 
                  :state, 
                  :subscribers_address, 
                  :subscribers_city, 
                  :subscribers_employer, 
                  :subscribers_first_name, 
                  :subscribers_last_name, 
                  :subscribers_phone, 
                  :subscribers_state, 
                  :subscribers_zipcode, 
                  :title, 
                  :zipcode,
                  :form_id,
                  :payer_id,
                  :dental_attributes,
                  :vision_attributes
                  
   belongs_to :form
   belongs_to :payer
   has_one :dental
   has_one :vision
   accepts_nested_attributes_for :dental, :vision
   
end
