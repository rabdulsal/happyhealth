class Note < ActiveRecord::Base
	include PublicActivity::Common

	attr_accessible	:info,
									:user_id

	belongs_to :user
end
