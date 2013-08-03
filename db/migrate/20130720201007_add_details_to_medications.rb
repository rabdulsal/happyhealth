class AddDetailsToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :start_date, :date
    add_column :medications, :end_date, :string
    add_column :medications, :directions, :text
    add_column :medications, :fill_instructions, :text
    add_column :medications, :status, :string
    add_column :medications, :indication, :string
  end
end
