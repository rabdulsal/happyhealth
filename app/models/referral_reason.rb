class ReferralReason < ActiveRecord::Base
  attr_accessible 	:visit_reason, :appointment_id

  belongs_to :appointment
end
