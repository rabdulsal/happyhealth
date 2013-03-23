class Office < ActiveRecord::Base
  attr_accessible :name,
                  :doctors_attributes,
                  :address,
                  :city,
                  :state,
                  :zipcode,
                  :phone,
                  :fax,
                  :email,
                  :pdf_attributes

  validates :name, :address, :city, :state, :zipcode, :phone, :email, :pdf, :presence => true

  has_many :doctors
  accepts_nested_attributes_for :doctors

  has_one :pdf
  accepts_nested_attributes_for :pdf
  has_many :users, through: :appointments


  delegate :form_name, to: :pdf, allow_nil: true


  def sorted_doctors
    self.doctors.sort {|a,b| a.title <=> b.title}
  end

  def abrv
    office_abrv = self.name.split("").ary
    #remove last 2 elements of the Array
    office_abrv[0]
  end
end
