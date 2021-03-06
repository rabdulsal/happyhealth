class FormsController < ApplicationController

  before_filter :correct_user

  def show
    @form = Form.find_by_user_id(params[:user_id])
    @user = User.find_by_id params[:user_id]
    @current_page = "profile_show"
    @total_allergies = @user.form.medical.allergies.count

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @form }
    end
  end

  def new
    @user = User.find_by_id(params[:user_id])

    if @user.form
      @form = @user.form
    else
      @form = Form.new

      @form.user_id = params[:user_id]
      @form.personal = Personal.new
      2.times { @form.emergencies << Emergency.new }
      insurance =  Insurance.create(:title => "Primary")
      # @form.insurances << Insurance.create(:title => "Secondary")
      insurance.dental = Dental.new #=> started adding here, but not 100% sure on getting things right
      insurance.vision = Vision.new
      @form.insurances << insurance
      @form.insurances = Insurance.new
      @form.insurances.dental << Dental.new
      @form.insurances.vision << Vision.new 
      @form.responsible = Responsible.new
      @form.medical = Medical.new
      3.times { @form.medical.allergies << Allergy.new }
      3.times { @form.medical.medications << Medication.new }
      @form.save
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form }
    end
  end

  def edit
    @form = Form.find(params[:id])
    @user = User.find_by_id(@form.user_id)
    @current_page = "profile_show"
  end

  def create
    @form = Form.new(params[:form])     

    respond_to do |format|
      if @form.save
        format.html { redirect_to user_form_path(current_user.id, @form.id), notice: 'Your HappyHealth Form was successfully created.' }
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @form = Form.find(params[:id])
    @user = User.find_by_id(@form.user_id)

    respond_to do |format|
      if @form.update_attributes(params[:form])

        # Auto-update Insurance "Self" Policy Holder with Personal Info
        if (@form.insurances[0].relationship_to_patient).downcase === "self"

          pers = @user.form.personal       
            
          @form.insurances[0].update_attributes(
            subscribers_last_name: pers.last_name, 
            subscribers_first_name: pers.first_name, 
            middle_initial: nil, 
            subscribers_address: pers.address, 
            subscribers_city: pers.city, 
            subscribers_state: pers.state, 
            subscribers_zipcode: pers.zip_code, 
            social_security: "", 
            birthdate: pers.date_of_birth, 
            sex: pers.gender, 
            subscribers_phone: pers.home_phone, 
            subscribers_employer: pers.employer
          )

        end

        format.html { redirect_to user_form_path(current_user.id), notice: 'Your HappyHealth Form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @form = Form.find_by_id(params[:id])
    @user = User.find_by_id(@form.user_id)
    @form.destroy

    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end
end
