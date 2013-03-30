class DentalsController < ApplicationController
  # GET /dentals
  # GET /dentals.json
  def index
    @dentals = Dental.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dentals }
    end
  end

  # GET /dentals/1
  # GET /dentals/1.json
  def show
    @dental = Dental.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dental }
    end
  end

  # GET /dentals/new
  # GET /dentals/new.json
  def new
    @dental = Dental.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dental }
    end
  end

  # GET /dentals/1/edit
  def edit
    @dental = Dental.find(params[:id])
  end

  # POST /dentals
  # POST /dentals.json
  def create
    @dental = Dental.new(params[:dental])

    respond_to do |format|
      if @dental.save
        format.html { redirect_to @dental, notice: 'Dental was successfully created.' }
        format.json { render json: @dental, status: :created, location: @dental }
      else
        format.html { render action: "new" }
        format.json { render json: @dental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dentals/1
  # PUT /dentals/1.json
  def update
    @dental = Dental.find(params[:id])

    respond_to do |format|
      if @dental.update_attributes(params[:dental])
        format.html { redirect_to @dental, notice: 'Dental was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dentals/1
  # DELETE /dentals/1.json
  def destroy
    @dental = Dental.find(params[:id])
    @dental.destroy

    respond_to do |format|
      format.html { redirect_to dentals_url }
      format.json { head :no_content }
    end
  end
end
