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
          # :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username,
                  :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :name

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  has_many :notes
  has_many :appointments
  has_many :doctors, through: :appointments
  has_many :insurance_queries, through: :appointments
  has_one :form
  has_many :offices, through: :appointments
  has_many :receipts

  include PublicActivity::Common

  #Override authentication to user :username

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

  def to_s
    if self.form && self.form.personal.first_name != "" && self.form.personal.first_name != nil
      self.form.first_name
    elsif self.name
      self.name.split(" ")[0]
    else
      "New User"
    end
  end

  def b_day # => Convert birthday if cell is blank
    b_day = self.form.personal.date_of_birth
    if b_day == ""
      b_day = Time.now.strftime("%m-%d-%Y")
    else
      b_day
    end
  end

  def age #=> Intended to make age calculation automatic based on self.date_of_birth
  #=> Must create .date_of_birth form format-validation => "dd-mm-yyyy"
      #dob = self.b_day
      bday = Date::strptime(b_day, "%m-%d-%Y")
      now = Time.now.utc.to_date
      age = now.year - bday.year - ((now.month > bday.month || (now.month == bday.month && now.day >= bday.day)) ? 0 : 1)

      if age == 0

      else
        age
      end

      # now.year - bday.year - ((now.month > bday.month || (now.month == bday.month && now.day >= bday.day)) ? 0 : 1)
  end

end
