class OfficesController < ApplicationController
  # GET /offices
  # GET /offices.json

  before_filter :logged_in
  before_filter :get_user
  before_filter :admin_user_access, except: [:index, :show, :save_receipt, :show_pdf]
  #before_filter :get_all_offices

  def index
    @offices = Office.all
    @appointment = Appointment.new
    @receipt = Receipt.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offices }
    end
  end

  def save_receipt
    @receipt = Receipt.new(params[:receipt])
    if @receipt.save
      redirect_to office_pdf_path(:office_id => @receipt.office_id)
    else
      redirect_to offices_path, :error => "Please check the terms of service agreement button"
    end
  end

  def show_pdf
    @office = Office.find_by_id(params[:office_id])
    @pdf = @office.pdfs
    @abrv = @office.abrv # => yields name of PDF form, _pdf.css.erb => name _pdf must match this name
    partial = "/appointments/forms/_#{@abrv}"
    logger.debug "ABRV: #{@abrv}"
    @format = "pdf"
    # respond_to do |format|
      # format.pdf do
          #@file = render_to_string :pdf => "#{@office.name}", #Comment-out to enable 'View in separate tab' functionality; un-comment for direct-download of PDF
          render :pdf => "#{@office.name}", #Comment-out for direct-download of PDF functionality; un-comment to view PDF in separate window
                 :template => "#{partial}.pdf.html.erb",
                 :layout => "pdf.html.erb",
                 :page_size => "A4",
                 :encoding => "UTF-8",
                 :show_as_html => params[:debug].present?

          #send_data(@file, :filename => @office.name,  :type=>"application/pdf") #Comment-out to enable 'View in separate tab' functionality; un-comment for direct-download of PDF
          # For debugging, use
          # http://localhost:3000/appointments/9.pdf?office=mada&debug=1
          # http://localhost:3000/office/download/5?debug=1


      # end
    # end
  end

  # GET /offices/1
  # GET /offices/1.json
  def show
    @office = Office.find(params[:id])
    @pdfs = Pdf.find_all_by_office_id(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @office }
    end
  end

  # GET /offices/new
  # GET /offices/new.json
  def new
    @office = Office.new
    @office.pdfs << Pdf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @office }
    end
  end

  # GET /offices/1/edit
  def edit
    @office = Office.find(params[:id])
  end

  # POST /offices
  # POST /offices.json
  def create
    @office = Office.new(params[:office])

    respond_to do |format|
      if @office.save
        format.html { redirect_to offices_path, notice: 'Office was successfully created. Please add some office forms.' }
        format.json { render json: @office, status: :created, location: @office }
      else
        format.html { render action: "new" }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offices/1
  # PUT /offices/1.json
  def update
    @office = Office.find(params[:id])

    respond_to do |format|
      if @office.update_attributes(params[:office])
        format.html { redirect_to new_office_pdf_path(@office), notice: 'Office was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offices/1
  # DELETE /offices/1.json
  def destroy
    @office = Office.find(params[:id])
    @office.destroy

    respond_to do |format|
      format.html { redirect_to offices_url }
      format.json { head :no_content }
    end
  end
end
