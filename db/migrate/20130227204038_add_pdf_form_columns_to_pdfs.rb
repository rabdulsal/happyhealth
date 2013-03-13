class AddPdfFormColumnsToPdfs < ActiveRecord::Migration
  def self.up
  	add_attachment :pdfs, :pdf_form
  end

  def self.down
  	remove_attachment :pdfs, :pdf_form
  end
end
