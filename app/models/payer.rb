class Payer < ActiveRecord::Base
  attr_accessible 	:payer_code, :payer_name 
  					
	has_many :insurance_queries
	has_many :insurances
end
