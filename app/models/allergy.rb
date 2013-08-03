class Allergy < ActiveRecord::Base
	attr_accessible		:info,
										:reaction,
										:severity,
										:medical_id

	belongs_to :medical
end
