class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_id params[:user_id]
  	if user
  		session[:user_id] = user.id
  		redirect_to user_form_path(user.id, user.form.id)
  		#redirect_to root_url
  	else
  		flash.now.alert = "That is not the correct Test User code"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to new_session_url, notice: "Logged out!"
  end
end
