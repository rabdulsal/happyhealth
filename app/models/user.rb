 class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # and :omniauthable
  devise  :database_authenticatable,
          :lockable,
          :registerable,
          :recoverable,
          :rememberable,
          :timeoutable,
          :trackable,
          :secure_validatable,
          :password_archivable,
          :session_limitable,
          :expirable,
          :security_questionable          

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name

  has_many :notes
  has_many :appointments
  has_many :doctors, through: :appointments
  has_many :insurance_queries, through: :appointments
  has_one :form
  has_many :offices, through: :appointments
  has_many :receipts

  def to_s
    if self.form && self.form.personal.first_name != "" && self.form.personal.first_name != nil
      self.form.first_name
    elsif self.name
      self.name.split(" ")[0]
    else
      "New User"
    end
  end

  def age #=> Intended to make age calculation automatic based on self.date_of_birth
  #=> Must create .date_of_birth form format-validation => "dd-mm-yyyy"
    dob = self.form.personal.date_of_birth

    if dob.nil?
      nil
    else
      bday = Date::strptime(dob, "%m-%d-%Y")
      now = Time.now.utc.to_date
      now.year - bday.year - ((now.month > bday.month || (now.month == bday.month && now.day >= bday.day)) ? 0 : 1)
    end
  end

end
