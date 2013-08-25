class Appointment < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :appt_date,
                  :appt_time,
                  :doctor_phone,
                  :user_id,
                  :office_id,
                  :doctor,
                  :doctor_id,
                  :tos_priv,
                  :referral_reason_attributes

  belongs_to :user
  belongs_to :doctor
  belongs_to :office
  has_many :insurance_queries
  has_one :referral_reason, dependent: :destroy

  accepts_nested_attributes_for :referral_reason
  
  def office
    Office.find_by_id(self.office_id)
  end

  def office_lat
    self.office.latitude
  end

  def office_long
    self.office.longitude
  end

end
