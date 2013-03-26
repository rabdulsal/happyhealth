class Pdf < ActiveRecord::Base

  attr_accessible :form_name, :office_id, :pdf_form

  has_attached_file :pdf_form, styles: {
                                          small: "150x150>",
                                          medium: "800x800>",
                                          large: "1400X1400>"
                                      }
  					# :default_url => lambda { |a| "#{a.instance.create_default_url}" }
  					# default_url: ActionController::Base.helpers.asset_path("/missing/:style.png"
  					#url: "/app/assets/images/:attachment/:id/:style/:basename.:extension",
            #path: ":rails_root:url"
  					

  # belongs_to :office, dependent: :destroy

  # def create_default_ul
  # 	   ActionController::Base.helpers.asset_path("/missing/:style.png", :digest => false)
  # end

end
