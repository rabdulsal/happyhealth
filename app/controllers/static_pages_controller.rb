class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to user_path(current_user.id)
    end
  end

  def help
  end

  def about
  end
end
