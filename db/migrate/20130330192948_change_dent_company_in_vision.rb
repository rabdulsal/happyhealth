class ChangeDentCompanyInVision < ActiveRecord::Migration
  def change
  	rename_column :visions, :dent_company, :vision_company
  end
end
