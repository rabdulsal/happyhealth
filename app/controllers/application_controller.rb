require 'open-uri'

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  before_filter :date_today

  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!

  protect_from_forgery

  protected

  # force_ssl if: :ssl_configured?

  # def ssl_configured?
  #   !Rails.env.development?
  # end

  def logged_in
    unless current_user.present?
      redirect_to root_path, notice: "Please Sign-in first"

    end
  end

  def correct_user

    if(params[:user_id])
      unless current_user == User.find_by_id(params[:user_id])
        flash[:error] = "Unauthorized Access"
        redirect_to root_path
        false
      end
    elsif(params[:id])
      unless current_user == User.find_by_id(params[:id])
        flash[:error] = "Unauthorized Access"
        redirect_to root_path
        false
      end
    end
  end

  def get_user
    @user = current_user
  end

  def admin_user_access
    unless current_user.is_admin.present?
      redirect_to user_path(@user), notice: "Unauthorized Access"
    end
  end

  def date_today
    @date_today = Time.now.strftime("%m/%d/%Y")
  end

  def process_insurance_query
    if params[:id]
      @ins_qry = InsuranceQuery.find_by_id(params[:id])
      #Database-stored info
      # key = @ins_qry.api_key
      key = "88fe267e-2214-c01a-829a-2eb08a09d497"
      npi = @ins_qry.provider_npi
      payer_name = @ins_qry.payer_name.split(' ').join('%20')
      payer_id = @ins_qry.payer_code
      subs_id = @ins_qry.subscriber_id
      prov_f_name = @ins_qry.physician_first_name
      prov_l_name = @ins_qry.physician_last_name
      subs_f_name = @ins_qry.subscriber_first_name
      subs_l_name = @ins_qry.subscriber_last_name
      subs_dob = @ins_qry.subscriber_dob

      # Hard-coded info
      # key = "88fe267e-2214-c01a-829a-2eb08a09d497"
      # npi = "1932213600"
      # payer_name = "Aetna"
      # payer_id = "2"
      # subs_id = "W167995579"
      # prov_f_name = "Ruby"
      # prov_l_name = "Puow"
      # subs_f_name = "Rashad"
      # subs_l_name = "AbdulSalaam"
      # subs_dob = "1980-08-17"

      if params[:insurance_query] && params[:insurance_query][:service_type_code]
        svc_code = params[:insurance_query][:service_type_code]
        uri = "https://v1.eligibleapi.net/service/all.json?service_type_code=#{svc_code}&api_key=#{key}&payer_name=#{payer_name}&payer_id=#{payer_id}&service_provider_last_name=#{prov_l_name}&service_provider_first_name=#{prov_f_name}&service_provider_npi=#{npi}&subscriber_id=#{subs_id}&subscriber_last_name=#{subs_l_name}&subscriber_first_name=#{subs_f_name}&subscriber_dob=#{subs_dob}"
      else
        uri = "https://v1.eligibleapi.net/plan/all.json?api_key=#{key}&payer_name=#{payer_name}&payer_id=#{payer_id}&service_provider_last_name=#{prov_l_name}&service_provider_first_name=#{prov_f_name}&service_provider_npi=#{npi}&subscriber_id=#{subs_id}&subscriber_last_name=#{subs_l_name}&subscriber_first_name=#{subs_f_name}&subscriber_dob=#{subs_dob}"
      end
    end
    logger.debug "URI: #{uri}"
    response = open(uri).read
    @eligibility = JSON.parse(response)
    logger.debug "Eligibility: #{@eligibility}"
  end

  private

  #Overwrite successful sign_in redirect to User's Health Form
  def after_sign_in_path_for(resource)
    user = User.find_by_id(1).form

    #Test Personal
    user.personal.update_attributes(
      first_name: "John",
      last_name: "Doe",
      middle_initial: "",
      date_of_birth: "6-11-1960",
      age: 52,
      gender: "Male",
      address: "12345 Home Street",
      city: "Cliffside Park",
      state: "NJ",
      zip_code: 7010,
      home_phone: "(555) 555-home",
      cell_phone: "(555) 555-cell",
      work_phone: "(555) 555-work",
      email_address: "you@email.com",
      marital_status: "Married",
      ethnicity: "Non-Hispanic",
      race: "White/Caucasian",
      employer: "Gold's Gym",
      employment_status: "Full-time",
      occupation: "Personal Trainer",
      work_address: "12345 Work Lane",
      number_of_dependents: nil,
      employer_phone: "(555) job-5555",
      employer_city: "New York",
      employer_state: "NY",
      employer_zipcode: "10027",
      relationship_to_responsible_party: nil,
      referred_by: "Dr. Oz"
      )

    #Test Insurance
    user.insurances[0].update_attributes(
      title: "Primary",
      relationship_to_patient: "Self",
      company: "Cigna",
      address: "BCBS NY Street Lane",
      city: "New York",
      state: "NY",
      zipcode: "10057",
      group_number: "BCBSNY1",
      group_name: "BCBSNY",
      eff_date: "2013-01-01",
      policy_number: "BCBSPolicy1",
      subscribers_last_name: user.personal.last_name,
      subscribers_first_name: user.personal.first_name,
      middle_initial: nil,
      subscribers_address: user.personal.address,
      subscribers_city: user.personal.city,
      subscribers_state: user.personal.state,
      subscribers_zipcode: user.personal.zip_code,
      social_security: "",
      birthdate: user.personal.date_of_birth,
      sex: user.personal.gender,
      subscribers_phone: user.personal.home_phone,
      subscribers_employer: user.personal.employer
      )

    #Test Emergency
    user.emergencies[0].update_attributes(
      name: "Jane Doe",
      relationship_to_patient: "Wife",
      phone_number: "(555) wife-num",
      address: "12345 wife home street",
      city: "Cliffside Park",
      state: "NJ",
      zipcode: "07010",
      )
    user.emergencies[1].update_attributes(
      name: "Gramma Doe",
      relationship_to_patient: "Grandmother",
      phone_number: "(555) gra-ndma",
      address: "12345 Grandma Lane",
      city: "Cliffside Park",
      state: "NJ",
      zipcode: "07010"
      )

    #Test Allergies
    user.medical.allergies[0].update_attributes(
      info: "silk tape"
      )
    user.medical.allergies[1].update_attributes(
      info: "penicillin"
      )
    user.medical.allergies[2].update_attributes(
      info: "latex"
      )

    #Test Medications
    user.medical.medications[0].update_attributes(
      reason: "sleep aid",
      info: "Lunesta / 3mg"
      )
    user.medical.medications[1].update_attributes(
      reason: "heart medication",
      info: "Nexium / 20mg"
      )
    user.medical.medications[2].update_attributes(
      reason: "hypothyroidism",
      info: "Synthroid / 25mg"
      )
    if current_user.form
      user_form_path(current_user.id, current_user.form.id)
    end
  end

  # Overwrite the sign_out redirect path method
  def after_sign_out_path_for(resource)
    "http://www.happyhealth.me"
  end

end
