class Problem < ActiveRecord::Base
	include PublicActivity::Common
	attr_accessible	:age_onset,
									:condition,
									:medical_id,
									:status

	belongs_to :medical
end
