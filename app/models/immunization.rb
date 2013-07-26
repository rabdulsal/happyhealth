class Immunization < ActiveRecord::Base
  attr_accessible :medical_id, :status, :vaccination, :vaccination_date
end
