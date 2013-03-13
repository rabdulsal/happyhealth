class Note < ActiveRecord::Base
  attr_accessible :info, :user_id
  
  belongs_to :user
end
