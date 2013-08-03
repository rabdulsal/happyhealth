class Procedure < ActiveRecord::Base
	attr_accessible		:medical_id,
										:procedure,
										:procedure_date,
										:target_site
end
