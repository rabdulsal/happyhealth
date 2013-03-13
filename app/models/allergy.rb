class Allergy < ActiveRecord::Base
  attr_accessible :info, :medical_id
  
  belongs_to :medical
end
