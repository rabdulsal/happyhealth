class Allergy < ActiveRecord::Base
	include PublicActivity::Common
	attr_accessible		:info,
										:reaction,
										:severity,
										:medical_id

	belongs_to :medical
end
