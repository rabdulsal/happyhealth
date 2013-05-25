class UsersController < ApplicationController

  before_filter :correct_user

  def show
    @user = User.find_by_id(params[:id])
    redirect_to user_form_url(@user.id, @user.id)
    if @user.form.nil?
      redirect_to new_user_form_path(@user.id)
    end
    @user.notes.sort!{|a,b|b.updated_at <=> a.updated_at}
    @appointments = @user.appointments.select{|a| a.appt_date.cweek == Date.today.cweek}
    @appointments.sort!{|a,b| a.appt_date <=> b.appt_date}
  end


end
