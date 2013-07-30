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
      @form.insurances <<  Insurance.create(:title => "Primary")
      @form.insurances << Insurance.create(:title => "Secondary")
      @form.dental << Dental.new
      @form.vision << Vision.new
      @form.responsible = Responsible.new
      @form.medical = Medical.new
      3.times { @form.medical.allergies << Allergy.new }
      3.times { @form.medical.medications << Medication.new }
      3.times { @form.medical.immunizations << Immunization.new }
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

      @form.update_activity params

      # Auto-update Insurance "Self" Policy Holder with Personal Info
      if (@form.insurances[0].relationship_to_patient).downcase == "self"

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

  # **************** FORM PRINTOUTS ******************

  def printout
    @user = User.find_by_id params[:id]
    @form = Form.find_by_id params[:user_id]
    @current_page = "printout"

    @personal = @user.form.personal
    @med_1 = @user.form.medical.medications[0]
    @med_2 = @user.form.medical.medications[1]
    @allergies = @user.form.medical.allergies
    @contact_1 = @user.form.emergencies[0]
    @contact_2 = @user.form.emergencies[1]
    @appt = @user.appointments


    # respond_to do |format|
    #   html = render_to_string(
    #     :layout => "pdf.html.erb" ,
    #     :action => "printout.html.erb",
    #     :formats => [:html],
    #     :handler => [:erb]
    #   )
    #   kit = PDFKit.new(html)
    #   kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/happy_health.css.scss.erb"
    #   send_data(kit.to_pdf,
    #     :filename => "#{@user.to_s}_Health_Form.pdf",
    #     :type => 'application/pdf'
    #     )
    #   return # to avoid double render call
    # end


    #Send Fax, receive confirmation
    # @fax = Phaxio.send_fax(to: '15555555555', string_data: "hello world")
    # Phaxio.get_fax_status(id: @fax["faxId"])

    # # Get a Fax and save it as a PDF
    # @pdf = Phaxio.get_fax_file(id: @fax["faxId"], type: "p")
    # File.open("received_test.pdf", "w") do |file|
    #   file << @pdf
    # end

  end
end
