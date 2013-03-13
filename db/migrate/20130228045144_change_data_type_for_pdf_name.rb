class ChangeDataTypeForPdfName < ActiveRecord::Migration
  def up
  	rename_column :pdfs, :name, :form_name    
  end

  def down
  	rename_column :pdfs, :form_name, :name
  end
end
