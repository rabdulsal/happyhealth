class Office < ActiveRecord::Base
  attr_accessible :name, 
                  :doctors_attributes,
                  :address,
                  :city,
                  :state,
                  :zipcode,
                  :phone,
                  :fax,
                  :email
  
  has_many :doctors
  accepts_nested_attributes_for :doctors
  
  has_one :pdf
  
  def sorted_doctors
    self.doctors.sort {|a,b| a.title <=> b.title}
  end

  def abrv
    office_abrv = self.name.split("").ary
    #remove last 2 elements of the Array
    office_abrv[0]
  end
end
