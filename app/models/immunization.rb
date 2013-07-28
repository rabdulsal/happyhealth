class Immunization < ActiveRecord::Base
	attr_accessible :medical_id,
									:status,
									:vaccination,
									:vaccination_date

	belongs_to :medical
end
