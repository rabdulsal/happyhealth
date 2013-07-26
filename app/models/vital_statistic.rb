class VitalStatistic < ActiveRecord::Base
  attr_accessible :blood_type, :bmi, :body_temp, :diastolic_bp, :height, :systolic_bp, :weight
end
