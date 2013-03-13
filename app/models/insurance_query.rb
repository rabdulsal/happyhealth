class InsuranceQuery < ActiveRecord::Base
  attr_accessible 	:api_key, 
          					:payer_id, 
          					:payer_name, 
          					:physician_first_name, 
          					:physician_last_name, 
          					:provider_npi, 
          					:service_type_code, 
          					:subscriber_dob, 
          					:subscriber_first_name, 
          					:subscriber_id, 
          					:subscriber_last_name,
          					:appointment_id,
                    :payer_code

  belongs_to :appointment
  belongs_to :payer
end
