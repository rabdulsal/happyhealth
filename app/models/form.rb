class Form < ActiveRecord::Base
  attr_accessible :user_id,
                  :personal_attributes,
                  :emergencies_attributes,
                  :insurances_attributes,
                  :responsible_attributes,
                  :medical_attributes

  belongs_to :user
  has_one :personal, dependent: :destroy
  has_one :responsible, dependent: :destroy
  has_one :medical, dependent: :destroy
  has_many :emergencies, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :payers, through: :insurances, dependent: :destroy
  accepts_nested_attributes_for :personal,
                                :emergencies,
                                :insurances,
                                :responsible,
                                :medical

  delegate :first_name, :last_name, to: :personal, allow_nil: true

end
