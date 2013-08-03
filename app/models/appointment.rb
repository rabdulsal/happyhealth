class Appointment < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :appt_date,
                  :doctor_phone,
                  :user_id,
                  :office_id,
                  :doctor,
                  :doctor_id,
                  :tos_priv

  belongs_to :user
  belongs_to :doctor
  belongs_to :office
  has_many :insurance_queries
  
  def office
    Office.find_by_id(self.office_id)
  end

end
