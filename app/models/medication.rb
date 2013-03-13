class Medication < ActiveRecord::Base
  attr_accessible :medical_id, :reason, :info
  
  belongs_to :medical
end
