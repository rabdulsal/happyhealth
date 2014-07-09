class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.json

  before_filter :current_user
  before_filter :yelp_search, only: :show

  def doctors
    @offices = Office.all
  end

  def get_doctors
    office_id = params[:office_id].to_i

    @doctors = Office.find_by_id(office_id).doctors
    respond_to do |format|
      format.json {render :json => @doctors}
    end
  end

  def get_pdf
    office_id = params[:office_id].to_i

    abrv = Office.find_by_id(office_id).abrv
    respond_to do |format|
      format.json {render :json => abrv.to_json} # => Controlled by Jscript in application.js
    end
  end

  def index
    @appointments = Appointment.find_all_by_user_id(current_user.id).sort!{|a,b|a.appt_date <=> b.appt_date}
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @user = User.find params[:user_id]
    @appointment = Appointment.find(params[:id])
    @office = Office.find_by_id(@appointment.office_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.json
  def new
    @offices = Office.all
    @user = User.find_by_id(params[:user_id])
    @appointment = Appointment.new
    #@appointment.doctor = Doctor.new
    @appointment.user_id = @user.id
    @appointment.referral_reason = ReferralReason.new

    @office_form_partials = []
    @offices.each do |office|
      @office_form_partials << "appointments/forms/#{office.abrv}.pdf.html.erb"
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = Appointment.find(params[:id])
    @user = User.find_by_id(params[:user_id])
  end

  # POST /appointments
  # POST /appointments.json
  def create
    #@appointment = Appointment.new(params[:appointment])
    @appointment = Appointment.new
    @appointment.office_id = params[:appointment][:office_id]
    @appointment.appt_date = params[:appointment][:appt_date]
    @appointment.user_id = params[:appointment][:user_id]
    @appointment.referral_reason = ReferralReason.new params[:appointment][:referral_reason_attributes]
    #@appointment.appt_time = params[:appointment][:appt_time]
    @appointment.doctor_id = Doctor.find_by_title(params[:appointment][:doctor]).id
    @appointment.save
    split_date = params[:appointment][:appt_date].split("/")
    date = split_date[1] + "/" + split_date[0] + "/" + split_date[2]
    @appointment.appt_date = Date.parse(date)
    @user = current_user
    @appointment.user_id = @user.id
    respond_to do |format|
      if @appointment.save
        @appointment.create_activity :create, owner: @user
        format.html { redirect_to user_appointment_path(current_user.id, @appointment.id), notice: 'Appointment was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
      else
        format.html { render action: "new" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
    @appointment = Appointment.find(params[:id])
    @user = User.find_by_id(params[:user_id])
    respond_to do |format|
      if  @appointment.update_attributes(params[:appointment])
        @appointment.create_activity :update, owner: @user
        format.html { redirect_to user_appointment_path(@user.id, @appointment.id), notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    @appointment.create_activity :destroy, owner: current_user
    respond_to do |format|
      format.html { redirect_to user_appointments_path(current_user.id) }
      format.json { head :no_content }
    end
  end

  # def show_pdf
  #   appointment = Appointment.find_by_id(params[:appointment_id])
  #   @office = Office.find_by_id(appointment.office.id)
  #   # @pdf = @office.pdfs
  #   @abrv = params[:office] # => yields name of PDF form, _pdf.css.erb file must match this name
  #   partial = "appointments/forms/#{@abrv}"
  #   logger.debug "ABRV: #{@abrv}"

  #   respond_to do |format|
  #     format.pdf do
  #         @file = render_to_string :pdf => "#{@office.name}", #Comment-out to enable 'View in separate tab' functionality; un-comment for direct-download of PDF
  #         #render :pdf => "#{@office.name}", #Comment-out for direct-download of PDF functionality; un-comment to view PDF in separate window
  #                :template => "#{partial}.pdf.html.erb",
  #                :layout => "pdf.html",
  #                :page_size => "A4",
  #                :encoding => "UTF-8",
  #                :show_as_html => params[:debug].present?

  #         send_data(@file, :filename => @office.name,  :type=>"application/pdf") #Comment-out to enable 'View in separate tab' functionality; un-comment for direct-download of PDF


  #         # For debugging, use
  #         # http://localhost:3000/appointments/9.pdf?office=mada&debug=1

  #     end
  #   end
  # end

  def show_pdf
    appointment = Appointment.find_by_id(params[:appointment_id])
    @office = Office.find_by_id(appointment.office.id)
    @abrv = @office.abrv
    @partial_abrv = "#{@abrv}.pdf.html.erb"    
    logger.debug "Partial name = #{@partial_abrv} | CSS => #{get_stylesheet}"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @office } 
      format.pdf {
        html = render_to_string(
          :layout => "pdf.html.erb" , 
          :action => "show.html.erb", 
          :formats => [:html], 
          :handler => [:erb]
          )
        kit = PDFKit.new(html)
        kit.stylesheets << get_stylesheet
        send_data(kit.to_pdf, 
                  :filename => "#{@office.name}.pdf", 
                  :type => 'application/pdf'
                  )
        return # to avoid double render call
      }     
    end
  end

  def get_stylesheet
    appointment = Appointment.find_by_id params[:appointment_id]
    office = Office.find_by_id(appointment.office.id)
    abrv = office.abrv
    if Rails.env.production?
      "#{Rails.root}/app/assets/stylesheets/#{abrv}.css.scss.erb"
    else
      "#{Rails.root}/app/assets/stylesheets/#{abrv}.css.scss.erb"
    end
  end
end
