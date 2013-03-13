class Medical < ActiveRecord::Base
  attr_accessible :form_id, :allergies_attributes, :medications_attributes
  
  belongs_to :form
  has_many :medications
  has_many :allergies
  
  accepts_nested_attributes_for :allergies, 
                                :medications
end
