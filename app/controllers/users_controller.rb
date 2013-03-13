class UsersController < ApplicationController
  
  before_filter :correct_user
  
  def show
    @user = User.find_by_id(params[:id])
    @user.notes.sort!{|a,b|b.updated_at <=> a.updated_at}
    @appointments = @user.appointments.select{|a| a.appt_date.cweek == Date.today.cweek}
    @appointments.sort!{|a,b| a.appt_date <=> b.appt_date}
  end

    
end
