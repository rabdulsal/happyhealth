class Problem < ActiveRecord::Base
	attr_accessible	:age_onset,
					:condition,
					:medical_id,
					:status

	belongs_to :medical
end
