class Dental < ActiveRecord::Base
  attr_accessible 	:dent_company, 
  					:eff_date, 
  					:group_name, 
  					:group_number, 
  					:insurance_id, 
  					:policy_number

  	belongs_to :insurance
end
