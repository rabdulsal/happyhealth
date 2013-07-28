class Receipt < ActiveRecord::Base
  attr_accessible :office_id,
									:tos_priv,
									:user_id

  validates_presence_of :tos_priv

  belongs_to :user
end
