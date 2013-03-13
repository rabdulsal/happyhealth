class PdfsController < ApplicationController
  
  before_filter :get_office
  before_filter :logged_in
  before_filter :get_user
  before_filter :admin_user_access, except: [:index, :show]

  def get_office
  	@office = Office.find params[:office_id]
  end

  def index
  	@pdfs = Pdf.find_all_by_office_id params[:office_id]
  end

  def new
   @pdf = Pdf.new    
  end

  def edit
  	@pdf = Pdf.find_by_id params[:id]
  end

  def create
  	@pdf = Pdf.new(params[:pdf])

  	if @pdf.save
  		redirect_to office_path(@office), notice: 'New Office Added!'
  	else
  		render action: 'new', notice: 'Sorry, an error occurred. Please try again.'  		
  	end
  end

  def update
  	@pdf = Pdf.find_by_id params[:id]

  	if @pdf.update_attributes params[:pdf]
  		redirect_to office_path(@office), notice: 'New Office Added!'
  	else
  		render action: 'new', notice: 'Sorry, an error occurred. Please try again.'  		
  	end
  end

  def show
  	@pdf = Pdf.find params[:id]
  end

  def destroy  	
  	@pdf = Pdf.find_by_id params[:id]
  	@pdf.destroy
  	redirect_to office_path@office, notice: "Office form deleted"
  end

end
