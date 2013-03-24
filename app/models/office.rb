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
                  :pdfs_attributes,
                  :abrv

  validates :name, :address, :city, :state, :presence => true

  has_many :doctors
  accepts_nested_attributes_for :doctors

  has_many :pdfs, dependent: :destroy
  accepts_nested_attributes_for :pdfs

  has_many :users, through: :appointments


  def sorted_doctors
    self.doctors.sort {|a,b| a.title <=> b.title}
  end

end
