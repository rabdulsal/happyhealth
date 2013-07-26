class Medication < ActiveRecord::Base
  attr_accessible 	:medical_id, 
  					:reason, 
  					:info,
  					:start_date,
  					:end_date,
  					:directions,
  					:fill_instructions,
  					:status,
  					:indication
  
  belongs_to :medical
end
