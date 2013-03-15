class Form < ActiveRecord::Base
  attr_accessible :user_id, 
                  :personal_attributes, 
                  :emergencies_attributes, 
                  :insurances_attributes, 
                  :responsible_attributes,
                  :medical_attributes
  
  belongs_to :user
  has_one :personal
  has_one :responsible
  has_one :medical
  has_many :emergencies
  has_many :insurances
  has_many :payers, through: :insurances
  accepts_nested_attributes_for :personal, 
                                :emergencies, 
                                :insurances, 
                                :responsible,
                                :medical
  
  delegate :first_name, :last_name, to: :personal, allow_nil: true

end
