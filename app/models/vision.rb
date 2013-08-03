class Vision < ActiveRecord::Base
  attr_accessible :vision_company,
  				  			:eff_date,
  				  			:group_name,
  				  			:group_number,
  				  			:form_id,
  				  			:policy_number

  belongs_to :form
end
