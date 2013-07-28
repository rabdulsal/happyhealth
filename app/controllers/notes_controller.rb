class NotesController < ApplicationController
  # GET /notes
  # GET /notes.json

  before_filter :correct_user

  def index
    @user = User.find_by_id(params[:user_id])
    @notes = @user.notes.order('updated_at desc').page(params[:page]).per(8)       #sort{|a,b| b.updated_at <=> a.updated_at}
    # @notes = notes.sort!{|a,b| b.updated_at <=> a.updated_at}
    # @notes = Note.page(params[:page]).per(8)
    @note = Note.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])
    @current_page = "notes_show"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @user = User.find_by_id(params[:user_id])
    @note = Note.new
    @note.user_id = @user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])
    @user = current_user
    @note.user_id = @user.id
    respond_to do |format|
      if @note.save
        @note.create_activity :create, owner: @note.user
        format.js
        format.html { redirect_to @user, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        @note.create_activity :update, owner: @note.user
        format.js
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @user = User.find_by_id(@note.user_id)
    @note.destroy

    @note.create_activity :destroy , owner: @note.user

    respond_to do |format|
      format.html { redirect_to user_notes_path(current_user.id) }
      format.json { head :no_content }
      format.js
    end
  end
end
