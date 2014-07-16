class SessionsController < ApplicationController
  def new
    @enterpage = "signin-background"
  end

  def create
  	user = User.find_by_id params[:user_id]
  	if user
  		session[:user_id] = user.id

  		#Set Test User Data

  		#Test Personal
    user.form.personal.update_attributes(
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
      )

    #Test Insurance
    user.form.insurances[0].update_attributes(
      title: "Primary",
      relationship_to_patient: "Self",
      company: "Cigna",
      address: "BCBS NY Street Lane",
      city: "New York",
      state: "NY",
      zipcode: "10057",
      group_number: "BCBSNY1",
      group_name: "BCBSNY",
      eff_date: "2014-01-01",
      policy_number: "BCBSPolicy1",
      subscribers_last_name: user.form.personal.last_name,
      subscribers_first_name: user.form.personal.first_name,
      middle_initial: nil,
      subscribers_address: user.form.personal.address,
      subscribers_city: user.form.personal.city,
      subscribers_state: user.form.personal.state,
      subscribers_zipcode: user.form.personal.zip_code,
      social_security: "",
      birthdate: user.form.personal.date_of_birth,
      sex: user.form.personal.gender,
      subscribers_phone: user.form.personal.home_phone,
      subscribers_employer: user.form.personal.employer
      )

    # user.form.insurances[1].update_attributes(
    #   title: "Secondary",
    #   relationship_to_patient: "Self",
    #   company: "Aetna",
    #   address: "BCBS NY Street Lane",
    #   city: "New York",
    #   state: "NY",
    #   zipcode: "10057",
    #   group_number: "AetnaNY1",
    #   group_name: "Aetna Insured",
    #   eff_date: "2014-01-01",
    #   policy_number: "AetnaPolicy1",
    #   subscribers_last_name: user.form.personal.last_name,
    #   subscribers_first_name: user.form.personal.first_name,
    #   middle_initial: nil,
    #   subscribers_address: user.form.personal.address,
    #   subscribers_city: user.form.personal.city,
    #   subscribers_state: user.form.personal.state,
    #   subscribers_zipcode: user.form.personal.zip_code,
    #   social_security: "",
    #   birthdate: user.form.personal.date_of_birth,
    #   sex: user.form.personal.gender,
    #   subscribers_phone: user.form.personal.home_phone,
    #   subscribers_employer: user.form.personal.employer
    #   )

    #Test Dental
    user.form.dental.update_attributes(
      eff_date: "2013-01-01",
      dent_company: "Guardian",
      policy_number: 1,
      group_number: 2,
      group_name: "Employee Plan"
      )

    #Test Vision
    user.form.dental.update_attributes(
      eff_date: "2013-01-01",
      dent_company: "VSP",
      policy_number: 10,
      group_number: 20,
      group_name: "Employee Vision Plan"
      )

    #Test Emergency
    user.form.emergencies[0].update_attributes(
      name: "Johnny Lee",
      relationship_to_patient: "Husband",
      phone_number: "(555) husb-num",
      address: "12345 husband home street",
      city: "Cliffside Park",
      state: "NJ",
      zipcode: "07010",
      )
    user.form.emergencies[1].update_attributes(
      name: "Gramma Lee",
      relationship_to_patient: "Grandmother",
      phone_number: "(555) gra-ndma",
      address: "12345 Grandma Lane",
      city: "Cliffside Park",
      state: "NJ",
      zipcode: "07010"
      )

    #Test Problems
    user.form.medical.problems[0].update_attributes(
      condition: "diabetes",
      age_onset: 30,
      status: "active" 
      )
    user.form.medical.problems[1].update_attributes(
      condition: "hypertension",
      age_onset: 30,
      status: "active"
      )
    user.form.medical.problems[2].update_attributes(
      condition: "hyperlipidemia",
      age_onset: 30,
      status: "active"
      )

    #Test Allergies
    user.form.medical.allergies[0].update_attributes(
      info: "silk tape",
      reaction: "skin rash",
      severity: "mild"
      )
    user.form.medical.allergies[1].update_attributes(
      info: "penicillin",
      reaction: "swollen face",
      severity: "severe"
      )
    user.form.medical.allergies[2].update_attributes(
      info: "latex",
      reaction: "itchy skin",
      severity: "mild"
      )

    #Test Medications
    user.form.medical.medications[0].update_attributes(
      reason: "sleep aid",
      info: "Lunesta / 3mg"
      )
    user.form.medical.medications[1].update_attributes(
      reason: "heart medication",
      info: "Nexium / 20mg"
      )
    user.form.medical.medications[2].update_attributes(
      reason: "hypothyroidism",
      info: "Synthroid / 25mg"
      )

    #Test Notes
    #user = User.find(33)
    user.notes.destroy_all

    user.notes.create(
      info: "Problem - Medication side-effect: I feel nauseous. don't want to think about food."
      )
    user.notes.create(
      info: "Update - Still no real appetite after a few days, particularly in the mornings. also feeling dizzy lately."
      )
    user.notes.create(
      info: "Reminder - Ask doctor about adjusting the medication, or other alternatives due to these strong side-effects."
      )

  		redirect_to user_form_path(user.id, user.form.id), notice: "You are signed-in as Test User 'Tammy Lee'. Welcome!"
  		#redirect_to root_url
  	else
  		flash.now.alert = "That is not the correct Test User code"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to enter_url, notice: "Logged out!"
  end
end
