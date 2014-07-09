class UsersController < ApplicationController

  before_filter :current_user

  def show # => User's Lifecycle Dashboard
    @user = User.find_by_id(params[:id])
    #redirect_to user_form_url(@user.id, @user.id)
    if @user.form.nil?
      redirect_to new_user_form_path(@user.id)
    end

    @activities = PublicActivity::Activity.order("created_at desc").
                                           where(owner_id: @user.id, owner_type: "User").
                                           page(params[:page]).per(15)

    # @user.notes.sort!{|a,b|b.updated_at <=> a.updated_at}
    # @appointments = @user.appointments.select{|a| a.appt_date.cweek == Date.today.cweek}
    # @appointments.sort!{|a,b| a.appt_date <=> b.appt_date}
  end

  def sign_in
    @user = User.find_by_id params[:id]
    @personal = @user.form.personal
  end

  # Devise Over-rides
  def new
    @user = User.new
  end

  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_form_path(@user.id), notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
  

end
