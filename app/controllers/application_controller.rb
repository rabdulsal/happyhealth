require 'open-uri'

class ApplicationController < ActionController::Base

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
    if current_user.form
      user_form_path(current_user.id, current_user.form.id)
    else
      current_user_path
    end
  end

  # Overwrite the sign_out redirect path method
  def after_sign_out_path_for(resource)
    "http://www.happyhealth.me"        
  end

end
