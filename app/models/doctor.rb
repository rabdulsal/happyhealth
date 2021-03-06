class Doctor < ActiveRecord::Base
  attr_accessible :office_id, :title
  
  belongs_to :office
  has_many :appointments
  has_many :users, through: :appointments
  has_many :insurance_queries, through: :appointments

  def self.office(office_id)
  	Doctor.where(office_id: office_id)
  end

end
