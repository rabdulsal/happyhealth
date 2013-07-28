# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130728162630) do

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "allergies", :force => true do |t|
    t.string   "info"
    t.integer  "medical_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "reaction"
    t.string   "severity"
    t.string   "status"
  end

  create_table "appointments", :force => true do |t|
    t.string   "doctor"
    t.date     "appt_date"
    t.string   "doctor_phone"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "office_id"
    t.integer  "doctor_id"
    t.boolean  "tos_priv",     :default => false
  end

  create_table "care_plans", :force => true do |t|
    t.text     "activity"
    t.date     "activity_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "dentals", :force => true do |t|
    t.datetime "eff_date"
    t.string   "dent_company"
    t.integer  "policy_number"
    t.integer  "group_number"
    t.string   "group_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "form_id"
  end

  create_table "discharge_instructions", :force => true do |t|
    t.text     "instruction"
    t.integer  "appointment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "discharge_medications", :force => true do |t|
    t.integer  "appointment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "doctors", :force => true do |t|
    t.string   "title"
    t.integer  "office_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emergencies", :force => true do |t|
    t.string   "name"
    t.string   "relationship_to_patient"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "form_id"
  end

  create_table "forms", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "functional_statuses", :force => true do |t|
    t.text     "functional_condition"
    t.date     "effective_dates"
    t.string   "status"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "immunizations", :force => true do |t|
    t.string   "vaccination"
    t.date     "vaccination_date"
    t.string   "status"
    t.integer  "medical_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "insurance_queries", :force => true do |t|
    t.string   "api_key"
    t.string   "payer_name"
    t.integer  "payer_id"
    t.string   "physician_last_name"
    t.string   "physician_first_name"
    t.integer  "provider_npi"
    t.string   "subscriber_id"
    t.string   "subscriber_last_name"
    t.string   "subscriber_first_name"
    t.string   "subscriber_dob"
    t.integer  "service_type_code"
    t.integer  "appointment_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "payer_code"
  end

  create_table "insurances", :force => true do |t|
    t.string   "title"
    t.string   "relationship_to_patient"
    t.string   "company"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "group_number"
    t.string   "group_name"
    t.date     "eff_date"
    t.string   "policy_number"
    t.string   "subscribers_last_name"
    t.string   "subscribers_first_name"
    t.string   "middle_initial"
    t.string   "subscribers_address"
    t.string   "subscribers_city"
    t.string   "subscribers_state"
    t.string   "subscribers_zipcode"
    t.string   "social_security"
    t.string   "birthdate"
    t.string   "sex"
    t.string   "subscribers_phone"
    t.string   "subscribers_employer"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "form_id"
    t.integer  "payer_id"
  end

  create_table "lab_results", :force => true do |t|
    t.text     "lab_info"
    t.string   "chemical_level"
    t.date     "lab_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "medicals", :force => true do |t|
    t.integer  "form_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "medications", :force => true do |t|
    t.string   "reason"
    t.integer  "medical_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "info"
    t.date     "start_date"
    t.string   "end_date"
    t.text     "directions"
    t.text     "fill_instructions"
    t.string   "status"
    t.string   "indication"
  end

  create_table "notes", :force => true do |t|
    t.text     "info"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.integer  "npi"
    t.string   "abrv"
  end

  create_table "old_passwords", :force => true do |t|
    t.string   "encrypted_password",       :null => false
    t.string   "password_salt"
    t.string   "password_archivable_type", :null => false
    t.integer  "password_archivable_id",   :null => false
    t.datetime "created_at"
  end

  add_index "old_passwords", ["password_archivable_type", "password_archivable_id"], :name => "index_password_archivable"

  create_table "payers", :force => true do |t|
    t.string   "payer_name"
    t.string   "payer_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pdfs", :force => true do |t|
    t.string   "form_name"
    t.integer  "office_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "pdf_form_file_name"
    t.string   "pdf_form_content_type"
    t.integer  "pdf_form_file_size"
    t.datetime "pdf_form_updated_at"
  end

  create_table "personals", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "date_of_birth"
    t.integer  "age"
    t.string   "ss_number"
    t.string   "gender"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "work_phone"
    t.string   "email_address"
    t.string   "marital_status"
    t.string   "ethnicity"
    t.string   "race"
    t.string   "employer"
    t.string   "employment_status"
    t.string   "occupation"
    t.string   "work_address"
    t.integer  "number_of_dependents"
    t.string   "employer_phone"
    t.string   "employer_city"
    t.string   "employer_state"
    t.string   "employer_zipcode"
    t.string   "relationship_to_responsible_party"
    t.string   "referred_by"
    t.integer  "form_id"
  end

  create_table "problems", :force => true do |t|
    t.date     "age_onset"
    t.string   "status"
    t.string   "condition"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "procedures", :force => true do |t|
    t.string   "procedure"
    t.date     "procedure_date"
    t.string   "target_site"
    t.integer  "medical_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "receipts", :force => true do |t|
    t.boolean  "tos_priv"
    t.integer  "office_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "referral_reasons", :force => true do |t|
    t.text     "visit_reason"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "responsibles", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "relationship_to_patient"
    t.string   "nickname"
    t.string   "address"
    t.string   "marital_status"
    t.string   "mailing_address"
    t.string   "number_of_dependents"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "social_security"
    t.string   "sex"
    t.string   "birthdate"
    t.integer  "age"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "employer"
    t.string   "employer_status"
    t.string   "occupation"
    t.string   "work_address"
    t.integer  "form_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "security_questions", :force => true do |t|
    t.string "locale", :null => false
    t.string "name",   :null => false
  end

  create_table "social_histories", :force => true do |t|
    t.text     "description"
    t.date     "start_date"
    t.string   "end_date"
    t.string   "behavior"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                  :default => "",    :null => false
    t.string   "encrypted_password",                     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "name"
    t.boolean  "is_admin",                               :default => false
    t.datetime "password_changed_at"
    t.string   "unique_session_id",        :limit => 20
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.integer  "security_question_id"
    t.string   "security_question_answer"
    t.integer  "failed_attempts",                        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["expired_at"], :name => "index_users_on_expired_at"
  add_index "users", ["last_activity_at"], :name => "index_users_on_last_activity_at"
  add_index "users", ["password_changed_at"], :name => "index_users_on_password_changed_at"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "visions", :force => true do |t|
    t.datetime "eff_date"
    t.string   "vision_company"
    t.integer  "policy_number"
    t.integer  "group_number"
    t.string   "group_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "form_id"
  end

  create_table "vital_statistics", :force => true do |t|
    t.integer  "height"
    t.integer  "weight"
    t.integer  "bmi"
    t.string   "blood_type"
    t.integer  "systolic_bp"
    t.integer  "diastolic_bp"
    t.integer  "body_temp"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
