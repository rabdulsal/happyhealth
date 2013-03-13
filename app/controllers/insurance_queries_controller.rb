require 'open-uri'

class InsuranceQueriesController < ApplicationController
  
  before_filter :logged_in
  before_filter :process_insurance_query, only: [:eligibility, :service]

  # GET /insurance_queries
  # GET /insurance_queries.json
  def index
    @insurance_queries = InsuranceQuery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @insurance_queries }
    end
  end

  # GET /insurance_queries/1
  # GET /insurance_queries/1.json
  def eligibility
    #Action handles GET Plan/all queries from Eligibleapi.com
    # if @eligiblity["error"] then @message = "Sorry, there was an error with the information you entered" end
    #   
    # logger.debug "message: #{@message}"
  end

  def service
    #Action handles GET Service/all queries from Eligibleapi.com
  end

  def show
    @insurance_query = InsuranceQuery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @insurance_query }
    end    
  end

  # GET /insurance_queries/new
  # GET /insurance_queries/new.json
  def new
    @insurance_query = InsuranceQuery.new
    #@payers = Payer.all.order('payer_name asc')
  end

  # GET /insurance_queries/1/edit
  def edit
    @insurance_query = InsuranceQuery.find(params[:id])
  end

  # POST /insurance_queries
  # POST /insurance_queries.json
  def create
    @insurance_query = InsuranceQuery.new(params[:insurance_query])
    payer = Payer.find_by_id(params[:insurance_query][:payer_id])
    logger.debug "#{params[:insurance_query]}"
    @insurance_query.payer_code = payer.payer_code
    @insurance_query.payer_name = payer.payer_name

    respond_to do |format|
      if @insurance_query.save
        format.html { redirect_to @insurance_query, notice: "Your query was successfully processed"}
        format.json { render json: @insurance_query, status: :created, location: @insurance_query }
      else
        format.html { render action: "new" }
        format.json { render json: @insurance_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /insurance_queries/1
  # PUT /insurance_queries/1.json
  def update
    @insurance_query = InsuranceQuery.find(params[:id])

    respond_to do |format|
      if  @insurance_query.update_attributes(params[:insurance_query])
          payer = Payer.find_by_id(@insurance_query.payer_id)
          @insurance_query.update_attributes(payer_name: payer.payer_name, payer_code: payer.payer_code)
        
        format.html { redirect_to @insurance_query, notice: 'Insurance query was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @insurance_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_queries/1
  # DELETE /insurance_queries/1.json
  def destroy
    @insurance_query = InsuranceQuery.find(params[:id])
    @insurance_query.destroy

    respond_to do |format|
      format.html { redirect_to insurance_queries_url }
      format.json { head :no_content }
    end
  end
end
