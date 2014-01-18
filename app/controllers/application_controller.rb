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
        uri = "https://gds.eligibleapi.com/v1.3/coverage/all.json?service_type_code=#{svc_code}&api_key=#{key}&payer_name=#{payer_name}&payer_id=#{payer_id}&service_provider_last_name=#{prov_l_name}&service_provider_first_name=#{prov_f_name}&service_provider_npi=#{npi}&subscriber_id=#{subs_id}&subscriber_last_name=#{subs_l_name}&subscriber_first_name=#{subs_f_name}&subscriber_dob=#{subs_dob}"
      else
        uri = "https://gds.eligibleapi.com/v1.3/coverage/all.json?api_key=#{key}&payer_id=#{payer_id}&provider_last_name=#{prov_l_name}&provider_first_name=#{prov_f_name}&provider_npi=#{npi}&member_id=#{subs_id}&member_last_name=#{subs_l_name}&member_first_name=#{subs_f_name}&member_dob=#{subs_dob}"
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
    
    user = User.find_by_id(params[:user_id])  

    #**************** Seed app with User Data *****************

    Personal.destroy_all
    Insurance.destroy_all
    Emergency.destroy_all
    Dental.destroy_all
    Vision.destroy_all
    Medical.destroy_all
    Problem.destroy_all
    Allergy.destroy_all
    Medication.destroy_all 
    Note.destroy_all  

    #Personal Hash
    personal = {
      first_name: "Tammy",
      last_name: "Lee",
      middle_initial: "",
      date_of_birth: "6-11-1970",
      age: 43,
      gender: "Female",
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
      race: "Asian",
      employer: "ABC Solutions",
      employment_status: "Full-time",
      occupation: "HR Manager",
      work_address: "12345 Work Lane",
      number_of_dependents: nil,
      employer_phone: "(555) job-5555",
      employer_city: "New York",
      employer_state: "NY",
      employer_zipcode: "10027",
      relationship_to_responsible_party: nil,
      referred_by: "Dr. Oz"
    }

    #Insurance Hash
    insurance = Insurance.create(
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
      subscribers_last_name: personal[:last_name],
      subscribers_first_name: personal[:first_name],
      middle_initial: nil,
      subscribers_address: personal[:address],
      subscribers_city: personal[:city],
      subscribers_state: personal[:state],
      subscribers_zipcode: personal[:zip_code],
      social_security: "",
      birthdate: personal[:date_of_birth],
      sex: personal[:gender],
      subscribers_phone: personal[:home_phone],
      subscribers_employer: personal[:employer]
    )

    #Dental Hash
    dental = {
      eff_date: "2013-01-01",
      dent_company: "Guardian",
      policy_number: 1,
      group_number: 2,
      group_name: "Employee Plan"
    }

    #Vision Hash
    vision = {
      eff_date: "2013-01-01",
      vision_company: "VSP",
      policy_number: 10,
      group_number: 20,
      group_name: "Employee Vision Plan"
    }

    #Emergencies
    emergencies_1 = Emergency.create(
      name: "Johnny Lee",
      relationship_to_patient: "Husband",
      phone_number: "(555) husb-num",
      address: "12345 husband home street",
      city: "Cliffside Park",
      state: "NJ",
      zipcode: "07010"
    )

    emergencies_2 = Emergency.create(
      name: "Gramma Lee",
      relationship_to_patient: "Grandmother",
      phone_number: "(555) gra-ndma",
      address: "12345 Grandma Lane",
      city: "Cliffside Park",
      state: "NJ",
      zipcode: "07010"
    )

    #Problems
    problem_1 = Problem.create(
      condition: "diabetes",
      age_onset: 30,
      status: "active"
    )

    problem_2 = Problem.create(
      condition: "hypertension",
      age_onset: 30,
      status: "active"
    )

    problem_3 = Problem.create(
      condition: "hyperlipidemia",
      age_onset: 30,
      status: "active"
    )

    #Allergies
    allergies_1 = Allergy.create(
      info: "silk tape",
      reaction: "skin rash",
      severity: "mild"
    )

    allergies_2 = Allergy.create(
      info: "penicillin",
      reaction: "swollen face",
      severity: "severe"
    )

    allergies_3 = Allergy.create(
      info: "latex",
      reaction: "itchy skin",
      severity: "mild"
    )

    #Medications
    medications_1 = Medication.create(
      reason: "sleep aid",
      info: "Lunesta / 3mg"
    )

    medications_2 = Medication.create(
      reason: "heart medication",
      info: "Nexium / 20mg"
    )

    medications_3 = Medication.create(
      reason: "hypothyroidism",
      info: "Synthroid / 25mg"
    )

    note_1 = Note.create(
      info: "Problem - Medication side-effect: I feel nauseous. don't want to think about food." 
    )
    note_2 =Note.create(
      info: "Update - Still no real appetite after a few days, particularly in the mornings. also feeling dizzy lately."
    )
    note_3 = Note.create(
      info: "Reminder - Ask doctor about adjusting the medication, or other alternatives due to these strong side-effects."
    )

    #if current_user.form.nil? && params[:user][:email] && params[:user][:password]

      
      current_user.form = Form.new
      form = current_user.form

      form.personal = Personal.new personal

      form.insurances << insurance

      form.dental = Dental.new dental

      form.vision = Vision.new vision

      form.emergencies << emergencies_1
      form.emergencies << emergencies_2

      form.medical = Medical.new
      form.medical.allergies << allergies_1
      form.medical.allergies << allergies_2
      form.medical.allergies << allergies_3

      form.medical.medications <<  medications_1
      form.medical.medications <<  medications_2
      form.medical.medications <<  medications_3

      form.medical.problems << problem_1
      form.medical.problems << problem_2
      form.medical.problems << problem_3

      form.save

      current_user.notes << note_1
      current_user.notes << note_2
      current_user.notes << note_3

      # current_user.notes << Note.new note_1
      # current_user.notes << Note.new note_2
      # current_user.notes << Note.new note_3
      # current_user.notes.save

      # notes.create note_1
      # notes.create note_2
      # notes.create note_3 

      #Test Personal
      # current_user.form.personal.create 

      # #Test Insurance
      # current_user.form.insurances[0].create insurance

      # #Test Dental
      # current_user.form.dental.create dental

      # #Test Vision
      # current_user.form.vision.create vision

      # #Test Emergency
      # current_user.form.emergencies[0].create emergencies_1
      # current_user.form.emergencies[1].create emergencies_2

      # #Test Problems
      # current_user.form.medical.problems[0].create problem_1
      # current_user.form.medical.problems[1].create problem_2
      # current_user.form.medical.problems[2].create problem_3

      # #Test Allergies
      # current_user.form.medical.allergies[0].create allergies_1
      # current_user.form.medical.allergies[1].create allergies_2
      # current_user.form.medical.allergies[2].create allergies_3

      # #Test Medications
      # current_user.form.medical.medications[0].create medications_1
      # current_user.form.medical.medications[1].create medications_2
      # current_user.form.medical.medications[2].create medications_3

      # #Test Notes
      # current_user.notes.create note_1
      # current_user.notes.create note_2
      # current_user.notes.create note_3 

      # form.save

    # else 

    #   #Insurance Hash
    #   insurance_new = {
    #     title: "Primary",
    #     relationship_to_patient: "Self",
    #     company: "Cigna",
    #     address: "BCBS NY Street Lane",
    #     city: "New York",
    #     state: "NY",
    #     zipcode: "10057",
    #     group_number: "BCBSNY1",
    #     group_name: "BCBSNY",
    #     eff_date: "2013-01-01",
    #     policy_number: "BCBSPolicy1",
    #     subscribers_last_name: personal[:last_name],
    #     subscribers_first_name: personal[:first_name],
    #     middle_initial: nil,
    #     subscribers_address: personal[:address],
    #     subscribers_city: personal[:city],
    #     subscribers_state: personal[:state],
    #     subscribers_zipcode: personal[:zip_code],
    #     social_security: "",
    #     birthdate: personal[:date_of_birth],
    #     sex: personal[:gender],
    #     subscribers_phone: personal[:home_phone],
    #     subscribers_employer: personal[:employer]
    #   }
    #     #Emergencies
    #   emergencies_1_new = {
    #     name: "Johnny Lee",
    #     relationship_to_patient: "Husband",
    #     phone_number: "(555) husb-num",
    #     address: "12345 husband home street",
    #     city: "Cliffside Park",
    #     state: "NJ",
    #     zipcode: "07010"
    #   }

    #   emergencies_2_new = {
    #     name: "Gramma Lee",
    #     relationship_to_patient: "Grandmother",
    #     phone_number: "(555) gra-ndma",
    #     address: "12345 Grandma Lane",
    #     city: "Cliffside Park",
    #     state: "NJ",
    #     zipcode: "07010"
    #   }

    #   #Problems
    #   problem_1_new = {
    #     condition: "diabetes",
    #     age_onset: 30,
    #     status: "active"
    #   }

    #   problem_2_new = {
    #     condition: "hypertension",
    #     age_onset: 30,
    #     status: "active"
    #   }

    #   problem_3_new = {
    #     condition: "hyperlipidemia",
    #     age_onset: 30,
    #     status: "active"
    #   }

    #   #Allergies
    #   allergies_1_new = {
    #     info: "silk tape",
    #     reaction: "skin rash",
    #     severity: "mild"
    #   }

    #   allergies_2_new = {
    #     info: "penicillin",
    #     reaction: "swollen face",
    #     severity: "severe"
    #   }

    #   allergies_3_new = {
    #     info: "latex",
    #     reaction: "itchy skin",
    #     severity: "mild"
    #   }

    #   #Medications
    #   medications_1_new = {
    #     reason: "sleep aid",
    #     info: "Lunesta / 3mg"
    #   }

    #   medications_2_new = {
    #     reason: "heart medication",
    #     info: "Nexium / 20mg"
    #   }

    #   medications_3_new = {
    #     reason: "hypothyroidism",
    #     info: "Synthroid / 25mg"
    #   }

    #   note_1 = { info: "Problem - Medication side-effect: I feel nauseous. don't want to think about food." }
    #   note_2 = { info: "Update - Still no real appetite after a few days, particularly in the mornings. also feeling dizzy lately." }
    #   note_3 = { info: "Reminder - Ask doctor about adjusting the medication, or other alternatives due to these strong side-effects." }

    #   #Test Personal
    #   current_user.form.personal.update_attributes personal

    #   #Test Insurance
    #   current_user.form.insurances[0].update_attributes insurance_new

    #   #Test Dental
    #   current_user.form.dental.update_attributes dental

    #   #Test Vision
    #   current_user.form.vision.update_attributes vision


    #   #Test Emergency
    #   current_user.form.emergencies[0].update_attributes emergencies_1_new
    #   current_user.form.emergencies[1].update_attributes emergencies_2_new

    #   #Test Problems
    #   current_user.form.medical.problems[0].update_attributes problem_1_new
    #   current_user.form.medical.problems[1].update_attributes problem_2_new
    #   current_user.form.medical.problems[2].update_attributes problem_3_new

    #   #Test Allergies
    #   current_user.form.medical.allergies[0].update_attributes allergies_1_new
    #   current_user.form.medical.allergies[1].update_attributes allergies_2_new
    #   current_user.form.medical.allergies[2].update_attributes allergies_3_new

    #   #Test Medications
    #   current_user.form.medical.medications[0].update_attributes medications_1_new
    #   current_user.form.medical.medications[1].update_attributes medications_2_new
    #   current_user.form.medical.medications[2].update_attributes medications_3_new

    #   #Notes
    #   current_user.notes.destroy_all

    #   #Test Notes
    #   current_user.notes.create note_1
    #   current_user.notes.create note_2
    #   current_user.notes.create note_3 

    # end   

    if current_user.form
      user_form_path(current_user.id, current_user.form.id)
    end
  end

  # Overwrite the sign_out redirect path method
  def after_sign_out_path_for(resource)
    "http://www.happyhealth.me"
  end

end
